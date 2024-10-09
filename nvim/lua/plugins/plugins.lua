require("lazy").setup({
  -- Core Plugins
  { 'echasnovski/mini.starter',    version = '*' }, -- starter screen
  { 'echasnovski/mini.cursorword', version = '*' }, -- highlight words matching under cursor
  { 'echasnovski/mini.trailspace', version = '*' }, -- trim space or whiteline easily
  'nvim-treesitter/nvim-treesitter',                -- nvim adaptation of the famous parsing library

  -- UI Enhancements
  'folke/which-key.nvim',                           -- key mappings configuration
  'nvim-tree/nvim-web-devicons',                    -- devicons
  'rcarriga/nvim-notify',                           -- better notifications
  'akinsho/bufferline.nvim',                        -- configurable bufferline
  'nvim-lualine/lualine.nvim',                      -- configurable statusline
  {
    'kevinhwang91/nvim-ufo',                        -- enhance folding capabilities
    dependencies = {
      'kevinhwang91/promise-async',                 -- async promise library
    },
  },
  'windwp/nvim-autopairs',                          -- autopair/close symbols
  'numToStr/Comment.nvim',                          -- commenting tool
  'chaoren/vim-wordmotion',                         -- better word motion (acknowledge camelCase, snake_case..)
  'ojroques/nvim-bufdel',                           -- easily close/delete buffers

  -- Git Integration
  'lewis6991/gitsigns.nvim',                        -- enhance git support
  'f-person/git-blame.nvim',                        -- show git blame inline
  'sindrets/diffview.nvim',                         -- easily cycling through git diffs

  -- Colorscheme
  { 'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  }, -- colorscheme

  -- Completion and Snippets
  'hrsh7th/nvim-cmp',                               -- completion engine for neovim
  'hrsh7th/cmp-nvim-lsp',                           -- nvim-cmp source for neovim's built-in language server client.
  'hrsh7th/cmp-path',                               -- nvim-cmp source for filesystem paths.
  'lukas-reineke/cmp-under-comparator',             -- better sort completion items
  'L3MON4D3/LuaSnip',                               -- snippet engine for Neovim
  'saadparwaiz1/cmp_luasnip',                       -- luasnip completion source for nvim-cmp

  -- LSP and Formatting
  'williamboman/mason.nvim',                        -- package manager for LSP, DAP, linters & formatters
  'williamboman/mason-lspconfig.nvim',              -- extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  'neovim/nvim-lspconfig',                          -- quickstart configs for nvim LSP
  'stevearc/conform.nvim',                          -- formatter for neovim
  'folke/trouble.nvim',                             -- a pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.

  -- File Navigation
  { 'nvim-tree/nvim-tree.lua', version = '*' },     -- file tree
  {
    'nvim-telescope/telescope.nvim',                -- Telescope
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    }
  },

  -- Miscellaneous
  'zbirenbaum/copilot.lua',                         -- enable github copilot
  'CopilotC-Nvim/CopilotChat.nvim',                 -- enhance chatting with copilot
  {
    'AckslD/nvim-neoclip.lua',                      -- clipboard manager
    dependencies = {
      'kkharji/sqlite.lua',                         -- db used by neoclip
    },
  },
  {
    "iamcco/markdown-preview.nvim",                 -- generate a markdown preview page in browser
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})
