-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local M = {}

function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    local group_id = vim.api.nvim_create_augroup(group_name, { clear = true })
    for _, def in ipairs(definition) do
      local opts = {
        group = group_id,
        pattern = def[2],
      }
      if type(def[3]) == "string" then
        opts.command = def[3]
      elseif type(def[4]) == "function" then
        opts.callback = def[4]
      end
      vim.api.nvim_create_autocmd(def[1], opts)
    end
  end
end

return M
