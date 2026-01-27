-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Configuration module for dbee-vault plugin

local M = {}

-- Default configuration
M.defaults = {
  -- Vault endpoint URL (REQUIRED - must be set by user or via VAULT_ADDR)
  vault_addr = os.getenv("VAULT_ADDR") or "",
  
  -- AWS region for authentication
  aws_region = os.getenv("AWS_REGION") or "us-east-1",
  
  -- AWS profile to use (alternative to explicit credentials)
  -- If set, this takes precedence over AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY
  aws_profile = os.getenv("AWS_PROFILE") or nil,
  
  -- Vault mount path for database credentials
  mount_path = "database/creds",
  
  -- Optional: Vault namespace (for Vault Enterprise)
  vault_namespace = os.getenv("VAULT_NAMESPACE") or nil,
  
  -- Optional: Vault AWS auth role name
  -- Leave empty for automatic role detection (requires Vault to be configured appropriately)
  vault_aws_role = os.getenv("VAULT_AWS_ROLE") or "",
  
  -- Optional: IAM Server ID header value
  -- Required if Vault AWS auth backend has iam_server_id_header_value configured
  vault_iam_server_id = os.getenv("VAULT_IAM_SERVER_ID") or nil,
  
  -- Request timeout in seconds
  timeout = 30,
  
  -- Default database type for connections
  -- Supported: postgres, mysql, mongodb, etc.
  default_db_type = "postgres",
}

-- Current configuration (will be merged with defaults)
M.options = {}

-- Validate configuration
local function validate_config(opts)
  local errors = {}
  
  -- Vault address is required
  if not opts.vault_addr or opts.vault_addr == "" then
    table.insert(errors, "vault_addr must be configured (set VAULT_ADDR environment variable or pass to setup())")
  elseif not opts.vault_addr:match("^https?://") then
    table.insert(errors, "vault_addr must start with http:// or https://")
  end
  
  -- Timeout must be positive
  if opts.timeout and (type(opts.timeout) ~= "number" or opts.timeout <= 0) then
    table.insert(errors, "timeout must be a positive number")
  end
  
  -- AWS region should be valid format
  if opts.aws_region and not opts.aws_region:match("^[a-z]+-[a-z]+-[0-9]+$") then
    vim.notify(
      "Warning: aws_region '" .. opts.aws_region .. "' doesn't match expected format (e.g., 'us-east-1')",
      vim.log.levels.WARN
    )
  end
  
  return errors
end

-- Setup configuration
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
  
  -- Validate configuration
  local errors = validate_config(M.options)
  if #errors > 0 then
    error("dbee-vault configuration error:\n  " .. table.concat(errors, "\n  "))
  end
  
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
