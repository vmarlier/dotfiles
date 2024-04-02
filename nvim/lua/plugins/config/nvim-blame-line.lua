---------------------
-- NVIM-Blame-Line --
---------------------
local au = require('util.au')
au.BufEnter = function()
	print(vim.bo.filetype)
end
au.BufEnter = { '*', 'EnableBlameLine' }
