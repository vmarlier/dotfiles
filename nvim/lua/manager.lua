-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Sections:
-- -> Bootstrapping
-- -> Modules

-------------------
-- Bootstrapping --
-------------------
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

-------------
-- Modules --
-------------
require "paq" {
    "savq/paq-nvim"; -- let Paq manage itself
    
    -- Dashboard, Helper, Term..
    "glepnir/dashboard-nvim"; -- display a dashboard
    "nvim-lua/plenary.nvim"; -- required for telescope
    "nvim-telescope/telescope.nvim"; -- highly extandable fuzzy finder
    "nvim-telescope/telescope-project.nvim"; -- manage project within Telescope
    "folke/which-key.nvim"; -- displays a popup with possible keybindings
    "akinsho/toggleterm.nvim"; -- terminal plugin

    -- Useful Stuff
    "lukas-reineke/indent-blankline.nvim"; -- indentation guides to all lines
    "terrortylor/nvim-comment"; -- comment easily
    "pseewald/vim-anyfold"; -- fold anything
    "vim-scripts/align"; -- align stuff
    "maxbrunsfeld/vim-yankstack"; -- maintains a history of previous yanks, changes and deletes

    -- Git
    "airblade/vim-gitgutter"; -- shows a git diff in the gutter (sign column)
    "tveskag/nvim-blame-line"; -- git blame in status bar or virtual text
    "sindrets/diffview.nvim"; -- review all changed files for any git rev.

    -- Navigation and Visual
    "kyazdani42/nvim-tree.lua"; -- nvim tree
    "glepnir/galaxyline.nvim"; -- statusline
    "romgrk/barbar.nvim"; -- tabline plugin with re-orderable, auto-sizing..

    -- Themes
    "kyazdani42/nvim-web-devicons"; -- lua fork of vim-devicons
    "joshdick/onedark.vim"; -- colorscheme
}
