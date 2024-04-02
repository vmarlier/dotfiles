-----------------
-- VIM-Anyfold --
-----------------
vim.o.foldlevel = 99
local au = require('util.au')
au.BufRead = function()
	print(vim.bo.filetype)
end
au.BufRead = { '*', 'AnyFoldActivate' }
