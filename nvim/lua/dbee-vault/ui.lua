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
  
  -- Create connection configuration for dbee
  local connection = {
    name = string.format("%s (%s)", database, permission),
    type = "postgres", -- Default to postgres, can be made configurable
    url = string.format(
      "postgresql://%s:%s@%s:%s/%s",
      credentials.username,
      credentials.password,
      credentials.hostname or "localhost",
      credentials.port or "5432",
      database
    ),
  }
  
  -- Get existing sources or create new list
  local sources = dbee.store.sources or {}
  
  -- Check if connection already exists and update it
  local found = false
  for i, source in ipairs(sources) do
    if source.name == connection.name then
      sources[i] = connection
      found = true
      break
    end
  end
  
  -- Add new connection if not found
  if not found then
    table.insert(sources, connection)
  end
  
  -- Update dbee with new sources
  dbee.store.sources = sources
  
  -- Try to refresh dbee UI if it's open
  local ok, _ = pcall(function()
    dbee.store.refresh()
  end)
  
  if not ok then
    -- If refresh failed, try to open dbee
    pcall(function()
      dbee.open()
    end)
  end
  
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
  
  vim.notify(
    string.format("Added connection: %s", connection.name),
    vim.log.levels.INFO
  )
end

-- Use a role with direct database-permission format
function M.use_direct_role(database, permission)
  local role = string.format("%s-%s", database, permission)
  M.use_role(role)
end

return M
