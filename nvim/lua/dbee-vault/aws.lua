-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- AWS authentication module for Vault

local Job = require("plenary.job")

local M = {}

-- Get AWS credentials from environment
local function get_aws_credentials()
  -- Check if AWS_PROFILE is set - if so, we'll let curl handle credential resolution
  local aws_profile = os.getenv("AWS_PROFILE")
  if aws_profile and aws_profile ~= "" then
    return {
      use_profile = true,
      profile = aws_profile,
    }
  end
  
  -- Otherwise, try explicit environment variables
  local access_key = os.getenv("AWS_ACCESS_KEY_ID")
  local secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
  local session_token = os.getenv("AWS_SESSION_TOKEN")
  
  if access_key and secret_key then
    return {
      use_profile = false,
      access_key = access_key,
      secret_key = secret_key,
      session_token = session_token,
    }
  end
  
  return nil
end

-- Base64 encode a string safely using plenary or vim.fn
local function base64_encode(str)
  -- Use plenary's base64 encoder if available, otherwise fall back to system command
  local ok, base64 = pcall(require, "plenary.strings")
  if ok and base64.base64_encode then
    return base64.base64_encode(str)
  end
  
  -- Fallback to shell command with proper escaping
  local escaped = vim.fn.shellescape(str)
  local result = vim.fn.system("printf %s " .. escaped .. " | base64 | tr -d '\\n'")
  return result:gsub("\n", "")
end

-- Generate signed STS GetCallerIdentity request for Vault AWS auth
-- This uses curl with --aws-sigv4 to properly sign the request
local function create_signed_sts_request(config)
  local credentials = get_aws_credentials()
  if not credentials then
    return nil, "AWS credentials not found. Set AWS_PROFILE or AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY"
  end
  
  local region = config.aws_region or "us-east-1"
  local sts_host = string.format("sts.%s.amazonaws.com", region)
  local sts_endpoint = "https://" .. sts_host .. "/"
  
  -- Prepare the request
  local request_body = "Action=GetCallerIdentity&Version=2011-06-15"
  local content_type = "application/x-www-form-urlencoded; charset=utf-8"
  
  local result = {}
  local errors = {}
  
  -- Build curl command with AWS SigV4 signing
  local args = {
    "-s",
    "-X", "POST",
    "-H", "Content-Type: " .. content_type,
    "--data", request_body,
    "--aws-sigv4", "aws:amz:" .. region .. ":sts",
  }
  
  local env = {}
  
  if credentials.use_profile then
    -- When using AWS_PROFILE, let curl inherit AWS environment
    -- AWS CLI credential resolution will handle the profile
    env.AWS_PROFILE = credentials.profile
    
    -- Also inherit AWS_CONFIG_FILE and AWS_SHARED_CREDENTIALS_FILE if set
    local config_file = os.getenv("AWS_CONFIG_FILE")
    local creds_file = os.getenv("AWS_SHARED_CREDENTIALS_FILE")
    
    if config_file then
      env.AWS_CONFIG_FILE = config_file
    end
    if creds_file then
      env.AWS_SHARED_CREDENTIALS_FILE = creds_file
    end
  else
    -- Use explicit credentials passed via environment variables
    env.AWS_ACCESS_KEY_ID = credentials.access_key
    env.AWS_SECRET_ACCESS_KEY = credentials.secret_key
    
    -- Session token is set as environment variable for curl to use in signing
    if credentials.session_token then
      env.AWS_SESSION_TOKEN = credentials.session_token
      table.insert(args, "-H")
      table.insert(args, "X-Amz-Security-Token: " .. credentials.session_token)
    end
  end
  
  -- Add the URL
  table.insert(args, sts_endpoint)
  
  -- Execute curl to create the signed request
  Job:new({
    command = "curl",
    args = args,
    env = env,
    on_exit = function(j, return_val)
      if return_val == 0 then
        result.data = table.concat(j:result(), "\n")
      else
        errors.data = table.concat(j:stderr_result(), "\n")
      end
    end,
  }):sync(30000) -- 30 second timeout
  
  if errors.data then
    return nil, "Failed to create signed STS request: " .. errors.data
  end
  
  -- Verify the response is valid
  if not result.data or result.data == "" then
    return nil, "Empty response from STS"
  end
  
  -- For Vault, we need to provide the base64-encoded components
  return {
    sts_endpoint = sts_endpoint,
    request_body = request_body,
    content_type = content_type,
    region = region,
    credentials = credentials,
  }, nil
end

-- Generate Vault login request using AWS authentication
function M.get_vault_login_headers(config)
  local sts_data, err = create_signed_sts_request(config)
  if err then
    return nil, err
  end
  
  -- Encode the components for Vault
  local encoded_url = base64_encode(sts_data.sts_endpoint)
  local encoded_body = base64_encode(sts_data.request_body)
  
  -- Build the headers as a table (JSON object)
  -- Vault expects each header value to be an array
  local headers_table = {
    ["Content-Type"] = {sts_data.content_type},
    ["Host"] = {"sts." .. sts_data.region .. ".amazonaws.com"},
  }
  
  -- Only add session token header if using explicit credentials (not profile)
  if not sts_data.credentials.use_profile and sts_data.credentials.session_token then
    headers_table["X-Amz-Security-Token"] = {sts_data.credentials.session_token}
  end
  
  -- Convert headers table to JSON string
  local headers_json = vim.fn.json_encode(headers_table)
  
  -- Base64 encode the JSON string
  local encoded_headers = base64_encode(headers_json)
  
  -- Build request headers
  local headers = {}
  
  -- Add IAM server ID header if configured
  -- This is required if your Vault AWS auth backend has iam_server_id_header_value configured
  if config.vault_iam_server_id then
    headers["X-Vault-AWS-IAM-Server-ID"] = config.vault_iam_server_id
  end
  
  local body_data = {
    iam_http_request_method = "POST",
    iam_request_url = encoded_url,
    iam_request_body = encoded_body,
    iam_request_headers = encoded_headers,
  }
  
  -- Add role if configured
  if config.vault_aws_role and config.vault_aws_role ~= "" then
    body_data.role = config.vault_aws_role
  end
  
  return headers, body_data
end

return M
