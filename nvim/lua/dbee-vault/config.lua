-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Configuration module for dbee-vault plugin

local M = {}

-- Default configuration
M.defaults = {
  -- Vault endpoint URL
  vault_addr = os.getenv("VAULT_ADDR") or "https://vault.example.com",
  
  -- AWS region for authentication
  aws_region = os.getenv("AWS_REGION") or "us-east-1",
  
  -- Vault mount path for database credentials
  mount_path = "database/creds",
  
  -- Optional: Vault namespace (for Vault Enterprise)
  vault_namespace = os.getenv("VAULT_NAMESPACE") or nil,
  
  -- Request timeout in seconds
  timeout = 30,
}

-- Current configuration (will be merged with defaults)
M.options = {}

-- Setup configuration
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
  return M.options
end

-- Get current configuration
function M.get()
  return M.options
end

-- Get a specific config value
function M.get_value(key)
  return M.options[key]
end

return M
