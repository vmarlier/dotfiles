-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- UI integration module for dbee-vault

local vault = require("dbee-vault.vault")
local config = require("dbee-vault.config")

local M = {}

-- Update nvim-dbee with new credentials
local function update_dbee_connection(role, credentials)
  local dbee = require("dbee")
  
  -- Parse the role name to extract database and permission
  -- Format: database-permission (e.g., deimos-admin, calypso-read)
  -- Use non-greedy match for database to handle names with hyphens
  local database, permission = role:match("^(.-)%-([^-]+)$")
  
  if not database then
    -- If pattern doesn't match, use the role name as database name
    database = role
    permission = "default"
  end
  
  -- Get configured database type
  local db_type = config.get_value("default_db_type") or "postgres"
  
  -- Build connection URL based on database type
  local connection_url
  if db_type == "postgres" then
    connection_url = string.format(
      "postgresql://%s:%s@%s:%s/%s",
      credentials.username,
      credentials.password,
      credentials.hostname or "localhost",
      credentials.port or "5432",
      database
    )
  elseif db_type == "mysql" then
    connection_url = string.format(
      "mysql://%s:%s@%s:%s/%s",
      credentials.username,
      credentials.password,
      credentials.hostname or "localhost",
      credentials.port or "3306",
      database
    )
  else
    -- Generic format
    connection_url = string.format(
      "%s://%s:%s@%s:%s/%s",
      db_type,
      credentials.username,
      credentials.password,
      credentials.hostname or "localhost",
      credentials.port or "5432",
      database
    )
  end
  
  -- Create connection configuration for dbee
  -- Note: nvim-dbee will handle credential masking in its UI
  local connection = {
    name = string.format("%s (%s) [Vault]", database, permission),
    type = db_type,
    url = connection_url,
  }
  
  -- Try to add connection using dbee sources API
  local sources = require("dbee.sources")
  local memory_source = sources.MemorySource:new({ connection })
  
  -- Add the source to dbee
  local ok, err = pcall(function()
    dbee.api.core.add_source(memory_source)
  end)
  
  if not ok then
    return nil, string.format(
      "Failed to add connection to dbee: %s\n" ..
      "The credentials were retrieved successfully but could not be added to dbee.\n" ..
      "You may need to add the connection manually.",
      tostring(err)
    )
  end
  
  -- Build notification message
  local lease_info = ""
  if credentials.lease_duration then
    local hours = math.floor(credentials.lease_duration / 3600)
    local minutes = math.floor((credentials.lease_duration % 3600) / 60)
    lease_info = string.format("Credentials expire in: %dh %dm", hours, minutes)
  end
  
  return connection, lease_info
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
  local connection, lease_info = update_dbee_connection(role, credentials)
  
  if not connection then
    -- lease_info contains the error message in this case
    vim.notify(lease_info, vim.log.levels.ERROR)
    return
  end
  
  -- Notify success
  local message = string.format("Added connection: %s\nUsername: %s", 
    connection.name,
    credentials.username
  )
  if lease_info and lease_info ~= "" then
    message = message .. "\n" .. lease_info
  end
  vim.notify(message, vim.log.levels.INFO)
  
  -- Try to open or refresh dbee UI
  local ok, open_err = pcall(function()
    require("dbee").open()
  end)
  
  if not ok then
    vim.notify(
      "Connection added but could not open dbee UI: " .. tostring(open_err) .. "\n" ..
      "Use :Dbee open to access the connection.",
      vim.log.levels.WARN
    )
  end
end

-- Use a role with direct database-permission format
function M.use_direct_role(database, permission)
  local role = string.format("%s-%s", database, permission)
  M.use_role(role)
end

return M
