-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- AWS authentication module for Vault

local M = {}

-- Get AWS credentials from environment or instance metadata
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
  
  -- TODO: Could add support for reading from ~/.aws/credentials or instance metadata
  return nil
end

-- Create AWS signature v4 for STS GetCallerIdentity request
local function create_aws_signature(config)
  local credentials = get_aws_credentials()
  if not credentials then
    return nil, "AWS credentials not found in environment"
  end
  
  -- Use curl to call AWS STS GetCallerIdentity
  local region = config.aws_region or "us-east-1"
  local sts_endpoint = string.format("https://sts.%s.amazonaws.com/", region)
  
  -- Build the STS request
  local cmd = string.format(
    [[curl -s -X POST '%s' -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' -d 'Action=GetCallerIdentity&Version=2011-06-15' --aws-sigv4 'aws:amz:%s:sts' --user '%s:%s']],
    sts_endpoint,
    region,
    credentials.access_key,
    credentials.secret_key
  )
  
  -- Add session token if present
  if credentials.session_token then
    cmd = cmd .. string.format(" -H 'X-Amz-Security-Token: %s'", credentials.session_token)
  end
  
  -- Execute the request
  local handle = io.popen(cmd)
  if not handle then
    return nil, "Failed to execute AWS STS request"
  end
  
  local result = handle:read("*a")
  handle:close()
  
  -- Check if we got a valid response
  if not result or result == "" then
    return nil, "Empty response from AWS STS"
  end
  
  return result, nil
end

-- Generate Vault login request using AWS authentication
function M.get_vault_login_headers(config)
  local sts_response, err = create_aws_signature(config)
  if err then
    return nil, err
  end
  
  -- Encode the STS response in base64
  local base64_sts = vim.fn.system("echo '" .. sts_response .. "' | base64 | tr -d '\n'")
  
  return {
    ["X-Vault-AWS-IAM-Server-ID"] = config.vault_addr,
  }, {
    iam_http_request_method = "POST",
    iam_request_url = base64_sts,
    iam_request_body = vim.fn.system("echo -n 'Action=GetCallerIdentity&Version=2011-06-15' | base64 | tr -d '\n'"),
    iam_request_headers = vim.fn.system("echo -n 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' | base64 | tr -d '\n'"),
    role = "", -- Role can be empty for automatic detection
  }
end

return M
