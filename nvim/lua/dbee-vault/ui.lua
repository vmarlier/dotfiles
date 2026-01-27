-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- UI integration module for dbee-vault

local vault = require("dbee-vault.vault")

local M = {}

-- Update nvim-dbee with new credentials
local function update_dbee_connection(role, credentials)
  local dbee = require("dbee")
  
  -- Parse the role name to extract database and permission
  -- Format: database-permission (e.g., deimos-admin, calypso-read)
  local database, permission = role:match("^(.+)%-([^-]+)$")
  
  if not database then
    -- If pattern doesn't match, use the role name as database name
    database = role
    permission = "default"
  end
  
  -- Extract connection details from credentials
  -- Vault returns: username, password, and optionally hostname, port
  local connection_url = string.format(
    "postgresql://%s:%s@%s:%s/%s",
    credentials.username,
    credentials.password,
    credentials.hostname or "localhost",
    credentials.port or "5432",
    database
  )
  
  -- Create connection configuration for dbee
  local connection = {
    name = string.format("%s (%s) [Vault]", database, permission),
    type = "postgres", -- Default to postgres, can be made configurable
    url = connection_url,
  }
  
  -- Try to add connection using dbee sources API
  -- The best approach is to use a MemorySource to inject the connection
  local sources = require("dbee.sources")
  local memory_source = sources.MemorySource:new({ connection })
  
  -- Add the source to dbee
  -- Note: This is a runtime addition, it won't persist across restarts
  local ok, result = pcall(function()
    dbee.api.core.add_source(memory_source)
  end)
  
  if not ok then
    -- Fallback: try to manipulate the internal state
    -- This is less ideal but might work if add_source is not available
    vim.notify(
      "Could not add source dynamically. Connection may need to be added manually.",
      vim.log.levels.WARN
    )
  end
  
  -- Notify user
  vim.notify(
    string.format("Retrieved credentials for: %s\nUsername: %s\nTTL: %s", 
      connection.name,
      credentials.username,
      credentials.lease_duration and (credentials.lease_duration .. "s") or "N/A"
    ),
    vim.log.levels.INFO
  )
  
  return connection
end

-- Show role picker using snacks.nvim
function M.pick_role()
  -- Get list of roles from Vault
  local roles, err = vault.list_roles()
  if err then
    vim.notify("Failed to list roles: " .. err, vim.log.levels.ERROR)
    return
  end
  
  if #roles == 0 then
    vim.notify("No roles found in Vault", vim.log.levels.WARN)
    return
  end
  
  -- Use snacks picker to select a role
  local Snacks = require("snacks")
  
  Snacks.picker.pick({
    items = roles,
    prompt = "Select database role:",
    format = function(item)
      return item
    end,
  }, function(selected)
    if selected then
      M.use_role(selected)
    end
  end)
end

-- Use a specific role (retrieve credentials and update dbee)
function M.use_role(role)
  vim.notify("Retrieving credentials for role: " .. role, vim.log.levels.INFO)
  
  -- Get credentials from Vault
  local credentials, err = vault.get_credentials(role)
  if err then
    vim.notify("Failed to get credentials: " .. err, vim.log.levels.ERROR)
    return
  end
  
  -- Update dbee with the new connection
  local connection = update_dbee_connection(role, credentials)
  
  -- Try to open or refresh dbee UI
  local ok, _ = pcall(function()
    require("dbee").open()
  end)
  
  if not ok then
    vim.notify("DbeeVault: Connection details retrieved but could not refresh dbee UI", vim.log.levels.WARN)
  end
end

-- Use a role with direct database-permission format
function M.use_direct_role(database, permission)
  local role = string.format("%s-%s", database, permission)
  M.use_role(role)
end

return M
