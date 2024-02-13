-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Sections:
-- -> Bootstrapping
-- -> Auto-Sync
-- -> Modules

-------------------
-- Bootstrapping --
-------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
 if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

---------------
-- Auto-Sync --
---------------
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost manager.lua source <afile> | PackerSync
  augroup end
]])

-------------
-- Modules --
-------------
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP, auto-completion.. see https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  use 'neovim/nvim-lspconfig' -- collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-path' -- nvim-cmp source for filesystem paths.
  use 'saadparwaiz1/cmp_luasnip' -- snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- snippets plugin

  -- Diagnostics, Lint...
  use 'folke/trouble.nvim' -- list for diagnostics, references, telescope results...

  -- Dashboard, Helper, Term..
  use 'glepnir/dashboard-nvim' -- display a dashboard
  use {'nvim-telescope/telescope.nvim', requires='nvim-lua/plenary.nvim'} -- highly extandable fuzzy finder
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'} -- simple and easy way to use the interface for tree-sitter
  use {'nvim-treesitter/playground'} -- 
  use 'folke/which-key.nvim' -- displays a popup with possible keybindings
  use 'akinsho/toggleterm.nvim' -- terminal plugin

  -- Navigation and Visual
  use {'nvim-tree/nvim-tree.lua', requires='nvim-tree/nvim-web-devicons'} -- nvim tree
  use 'rcarriga/nvim-notify' -- notification system
  use 'akinsho/bufferline.nvim' -- tabline plugin with re-orderable, auto-sizing..
  use {'nvim-lualine/lualine.nvim'} -- statusline

  -- Useful Stuff
  use 'pseewald/vim-anyfold' -- fold anything
  use 'windwp/nvim-autopairs' -- powerful autopair plugin
  use 'lukas-reineke/indent-blankline.nvim' -- indentation guides
  use 'Vonr/align.nvim' -- minimal align features

  -- Git
  use 'airblade/vim-gitgutter' -- shows a git diff in the gutter (sign column)
  use 'tveskag/nvim-blame-line' -- git blame in status bar or virtual text
  use 'sindrets/diffview.nvim' -- review all changed files for any git rev.

  -- Themes
  use 'EdenEast/nightfox.nvim'

  -- Language Specific
  use {'iamcco/markdown-preview.nvim', ft = {'markdown'}, run = 'cd app && yarn install', cmd = 'MarkdownPreview'} -- preview mardown files

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

