-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local M = {}

function M.path(path)
  return vim.fn.expand(path)
end

return M
