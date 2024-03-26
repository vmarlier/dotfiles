-----------------
-- VIM-Anyfold --
-----------------
vim.o.foldlevel = 99
local au = require('au')
au.BufRead = function()
  print(vim.bo.filetype)
end
au.BufRead = { '*', 'AnyFoldActivate' }
