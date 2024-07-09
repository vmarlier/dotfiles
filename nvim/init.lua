-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- require sub-modules - require order is important !
require('utils.index')
require('plugins.index')
require('config.index')

-- import only when you need to update the readme
--require('custom.readme')
