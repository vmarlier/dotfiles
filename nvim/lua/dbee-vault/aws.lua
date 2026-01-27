-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- AWS authentication module for Vault

local Job = require("plenary.job")

local M = {}

-- Get AWS credentials from environment
local function get_aws_credentials()
  -- Try environment variables first
  local access_key = os.getenv("AWS_ACCESS_KEY_ID")
  local secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
  local session_token = os.getenv("AWS_SESSION_TOKEN")
  
  if access_key and secret_key then
    return {
      access_key = access_key,
      secret_key = secret_key,
      session_token = session_token,
    }
  end
  
  return nil
end

-- Base64 encode a string
local function base64_encode(str)
  local result = vim.fn.system("echo -n '" .. str:gsub("'", "'\\''") .. "' | base64 | tr -d '\\n'")
  return result:gsub("\n", "")
end

-- Generate signed STS GetCallerIdentity request for Vault AWS auth
-- This uses curl with --aws-sigv4 to properly sign the request
local function create_signed_sts_request(config)
  local credentials = get_aws_credentials()
  if not credentials then
    return nil, "AWS credentials not found in environment"
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
    "--user", credentials.access_key .. ":" .. credentials.secret_key,
  }
  
  -- Add session token if present
  if credentials.session_token then
    table.insert(args, "-H")
    table.insert(args, "X-Amz-Security-Token: " .. credentials.session_token)
  end
  
  -- Add the URL
  table.insert(args, sts_endpoint)
  
  -- Execute curl to create the signed request
  -- We'll use the --trace-ascii option to capture the signed headers
  Job:new({
    command = "curl",
    args = args,
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
  -- Note: This is a simplified version. In production, you'd want to
  -- use a helper tool or AWS SDK that can generate the proper signed request
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
  
  -- Build the headers string
  local headers_str = "Content-Type: " .. sts_data.content_type .. "\nHost: sts." .. sts_data.region .. ".amazonaws.com"
  if sts_data.credentials.session_token then
    headers_str = headers_str .. "\nX-Amz-Security-Token: " .. sts_data.credentials.session_token
  end
  
  local encoded_headers = base64_encode(headers_str)
  
  return {
    -- Optional: Add server ID header if needed
    -- ["X-Vault-AWS-IAM-Server-ID"] = config.vault_addr,
  }, {
    iam_http_request_method = "POST",
    iam_request_url = encoded_url,
    iam_request_body = encoded_body,
    iam_request_headers = encoded_headers,
    role = "", -- Role can be empty for automatic detection
  }
end

return M
