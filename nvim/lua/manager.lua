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

  -- Completion & Linting
  use 'neovim/nvim-lspconfig' -- requirement for goldsmith
  use 'williamboman/nvim-lsp-installer' -- requirement for goldsmith
  use 'jose-elias-alvarez/null-ls.nvim' -- requirement for goldsmith


  -- Dashboard, Helper, Term..
  use 'glepnir/dashboard-nvim' -- display a dashboard
  use {'nvim-telescope/telescope.nvim', requires='nvim-lua/plenary.nvim'} -- highly extandable fuzzy finder
  use 'nvim-telescope/telescope-project.nvim' -- manage project within Telescope
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'} -- simple and easy way to use the interface for tree-sitter
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- requirement for goldsmith
  use 'folke/which-key.nvim' -- displays a popup with possible keybindings
  use 'akinsho/toggleterm.nvim' -- terminal plugin

  -- Navigation and Visual
  use {'kyazdani42/nvim-tree.lua', requires='kyazdani42/nvim-web-devicons'} -- nvim tree
  use {'glepnir/galaxyline.nvim', branch='main'} -- statusline
  use 'romgrk/barbar.nvim' -- tabline plugin with re-orderable, auto-sizing..

  -- Useful Stuff
  use 'lukas-reineke/indent-blankline.nvim' -- indentation guides to all lines
  use 'terrortylor/nvim-comment' -- comment easily
  use 'pseewald/vim-anyfold' -- fold anything
  use 'vim-scripts/align' -- align stuff:wq
  use 'maxbrunsfeld/vim-yankstack' -- maintains a history of previous yanks, changes and deletes
  use 'raimondi/delimitmate' -- autoclosing quotes, brackets...

  -- Git
  use 'airblade/vim-gitgutter' -- shows a git diff in the gutter (sign column)
  use 'tveskag/nvim-blame-line' -- git blame in status bar or virtual text
  use 'sindrets/diffview.nvim' -- review all changed files for any git rev.

  -- Themes
  use 'joshdick/onedark.vim' -- colorscheme

  -- Language Specific
  use {'iamcco/markdown-preview.nvim', ft = {'markdown'}, run = 'cd app && yarn install', cmd = 'MarkdownPreview'} -- preview mardown files
  use {'WhoIsSethDaniel/goldsmith.nvim', ft = {'golang'}, requires='antoinemadec/FixCursorHold.nvim'} -- Golang support

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

