-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Vault API client module

local config = require("dbee-vault.config")
local aws = require("dbee-vault.aws")
local Job = require("plenary.job")

local M = {}

-- Cached Vault token
local vault_token = nil

-- Authenticate with Vault using AWS IAM
local function authenticate()
  local cfg = config.get()
  
  -- Get AWS authentication headers
  local headers, body_data = aws.get_vault_login_headers(cfg)
  if not headers then
    return nil, body_data -- body_data contains error message
  end
  
  -- Prepare the login request
  local url = cfg.vault_addr .. "/v1/auth/aws/login"
  local body = vim.fn.json_encode(body_data)
  
  local response = {}
  local errors = {}
  
  -- Build curl command
  local args = {
    "-s",
    "-X", "POST",
    "-H", "Content-Type: application/json",
    "-d", body,
    url
  }
  
  -- Add namespace header if configured
  if cfg.vault_namespace then
    table.insert(args, "-H")
    table.insert(args, "X-Vault-Namespace: " .. cfg.vault_namespace)
  end
  
  -- Add custom headers
  for key, value in pairs(headers) do
    table.insert(args, "-H")
    table.insert(args, key .. ": " .. value)
  end
  
  -- Execute request
  Job:new({
    command = "curl",
    args = args,
    on_exit = function(j, return_val)
      if return_val == 0 then
        local result = table.concat(j:result(), "\n")
        response.data = result
      else
        errors.data = table.concat(j:stderr_result(), "\n")
      end
    end,
  }):sync(cfg.timeout * 1000)
  
  if errors.data then
    return nil, "Authentication failed: " .. errors.data
  end
  
  -- Parse response
  local ok, decoded = pcall(vim.fn.json_decode, response.data)
  if not ok or not decoded then
    return nil, "Failed to parse authentication response"
  end
  
  if decoded.errors then
    return nil, "Vault error: " .. table.concat(decoded.errors, ", ")
  end
  
  if not decoded.auth or not decoded.auth.client_token then
    return nil, "No token in authentication response"
  end
  
  vault_token = decoded.auth.client_token
  return vault_token, nil
end

-- Ensure we have a valid Vault token
local function ensure_authenticated()
  if vault_token then
    return vault_token, nil
  end
  
  return authenticate()
end

-- Make an authenticated request to Vault
local function vault_request(method, path, body)
  local token, err = ensure_authenticated()
  if err then
    return nil, err
  end
  
  local cfg = config.get()
  local url = cfg.vault_addr .. "/v1/" .. path
  
  local response = {}
  local errors = {}
  
  -- Build curl command
  local args = {
    "-s",
    "-X", method,
    "-H", "X-Vault-Token: " .. token,
    "-H", "Content-Type: application/json",
  }
  
  -- Add namespace header if configured
  if cfg.vault_namespace then
    table.insert(args, "-H")
    table.insert(args, "X-Vault-Namespace: " .. cfg.vault_namespace)
  end
  
  -- Add body if present
  if body then
    table.insert(args, "-d")
    table.insert(args, vim.fn.json_encode(body))
  end
  
  table.insert(args, url)
  
  -- Execute request
  Job:new({
    command = "curl",
    args = args,
    on_exit = function(j, return_val)
      if return_val == 0 then
        local result = table.concat(j:result(), "\n")
        response.data = result
      else
        errors.data = table.concat(j:stderr_result(), "\n")
      end
    end,
  }):sync(cfg.timeout * 1000)
  
  if errors.data then
    return nil, "Request failed: " .. errors.data
  end
  
  -- Parse response
  local ok, decoded = pcall(vim.fn.json_decode, response.data)
  if not ok or not decoded then
    return nil, "Failed to parse response"
  end
  
  if decoded.errors then
    return nil, "Vault error: " .. table.concat(decoded.errors, ", ")
  end
  
  return decoded, nil
end

-- List available database roles
function M.list_roles()
  local cfg = config.get()
  local path = cfg.mount_path
  
  local response, err = vault_request("LIST", path)
  if err then
    return nil, err
  end
  
  if not response.data or not response.data.keys then
    return {}, nil
  end
  
  return response.data.keys, nil
end

-- Get credentials for a specific role
function M.get_credentials(role)
  local cfg = config.get()
  local path = cfg.mount_path .. "/" .. role
  
  local response, err = vault_request("GET", path)
  if err then
    return nil, err
  end
  
  if not response.data then
    return nil, "No credentials in response"
  end
  
  return response.data, nil
end

-- Clear cached token (force re-authentication on next request)
function M.clear_token()
  vault_token = nil
end

return M
