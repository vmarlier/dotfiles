-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Main module for dbee-vault plugin

local config = require("dbee-vault.config")
local ui = require("dbee-vault.ui")
local vault = require("dbee-vault.vault")

local M = {}

-- Setup the plugin
function M.setup(opts)
  config.setup(opts)
  
  -- Create user commands
  vim.api.nvim_create_user_command("DbeeVaultPick", function()
    ui.pick_role()
  end, {
    desc = "Pick a database role from Vault using a picker",
  })
  
  vim.api.nvim_create_user_command("DbeeVaultUse", function(args)
    if args.args == "" then
      vim.notify(
        "Usage: DbeeVaultUse <role>\n" ..
        "Example: DbeeVaultUse deimos-admin\n" ..
        "Role format: <database>-<permission>",
        vim.log.levels.ERROR
      )
      return
    end
    ui.use_role(args.args)
  end, {
    nargs = 1,
    desc = "Use a specific database role from Vault (format: database-permission)",
    complete = function()
      local roles, err = vault.list_roles()
      if err then
        return {}
      end
      return roles
    end,
  })
  
  vim.api.nvim_create_user_command("DbeeVaultDirect", function(args)
    local parts = vim.split(args.args, "%s+")
    if #parts ~= 2 then
      vim.notify(
        "Usage: DbeeVaultDirect <database> <permission>\n" ..
        "Example: DbeeVaultDirect deimos admin",
        vim.log.levels.ERROR
      )
      return
    end
    ui.use_direct_role(parts[1], parts[2])
  end, {
    nargs = "+",
    desc = "Use a database role with direct database-permission format",
  })
  
  vim.api.nvim_create_user_command("DbeeVaultClearToken", function()
    vault.clear_token()
    vim.notify("Vault token cleared", vim.log.levels.INFO)
  end, {
    desc = "Clear cached Vault token (force re-authentication)",
  })
end

return M
