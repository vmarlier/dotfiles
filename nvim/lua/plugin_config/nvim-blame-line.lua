---------------------
-- NVIM-Blame-Line --
---------------------
local au = require('au')
au.BufEnter = function()
  print(vim.bo.filetype)
end
au.BufEnter = { '*', 'EnableBlameLine' }
