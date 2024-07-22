require("lazy").setup({
  { 'echasnovski/mini.starter',    version = '*' }, -- starter screen
  { 'echasnovski/mini.cursorword', version = '*' }, -- highlight words matching under cursor
  { 'echasnovski/mini.trailspace', version = '*' }, -- trim space or whiteline easily
  'nvim-treesitter/nvim-treesitter',                -- nvim adaptation of the famous parsing library
  'folke/which-key.nvim',                           -- key mappings configuration
  'zbirenbaum/copilot.lua',                         -- enable github copilot
  'CopilotC-Nvim/CopilotChat.nvim',                 -- enhance chatting with copilot
  {
    "nvim-neo-tree/neo-tree.nvim", -- file tree
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  'nvim-tree/nvim-web-devicons',                    -- devicons
  'rcarriga/nvim-notify',                           -- better notifications
  'akinsho/bufferline.nvim',                        -- configurable bufferline
  'nvim-lualine/lualine.nvim',                      -- configurable statusline
  {
    'kevinhwang91/nvim-ufo', -- enhance folding capabilities
    dependencies = {
      'kevinhwang91/promise-async', -- clipboard manager     -- db used by neoclip
    },
  },
  'windwp/nvim-autopairs',     -- autopair/close symbols
  'akinsho/toggleterm.nvim',   -- toggle terminals
  {
    'AckslD/nvim-neoclip.lua', -- clipboard manager
    dependencies = {
      'kkharji/sqlite.lua',    -- db used by neoclip
    },
  },
  'chaoren/vim-wordmotion',                                            -- better word motion (acknowledge camelCase, snake_case..)
  'ojroques/nvim-bufdel',                                              -- easily close/delete buffers
  'lewis6991/gitsigns.nvim',                                           -- enhance git support
  'f-person/git-blame.nvim',                                           -- show git blame inline
  'sindrets/diffview.nvim',                                            -- easily cycling through git diffs
  -- colorscheme
  { 'catppuccin/nvim',         name = 'catppuccin', priority = 1000 }, -- colorscheme
  -- completion
  'hrsh7th/nvim-cmp',                                                  -- completion engine for neovim
  'hrsh7th/cmp-nvim-lsp',                                              -- nvim-cmp source for neovim's built-in language server client.
  'hrsh7th/cmp-path',                                                  -- nvim-cmp source for filesystem paths.
  'lukas-reineke/cmp-under-comparator',                                -- better sort completion items
  'L3MON4D3/LuaSnip',                                                  -- snippet engine for Neovim
  'saadparwaiz1/cmp_luasnip',                                          -- luasnip completion source for nvim-cmp
  'williamboman/mason.nvim',                                           -- package manager for LSP, DAP, linters & formatters
  'williamboman/mason-lspconfig.nvim',                                 -- extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  'neovim/nvim-lspconfig',                                             -- quickstart configs for nvim LSP
  'stevearc/conform.nvim',                                             -- formatter for neovim
  'folke/trouble.nvim',                                                -- a pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  'stevearc/aerial.nvim',                                              -- code outline window for skimming and quick navigation
  -- telescope
  {
    'nvim-telescope/telescope.nvim', -- Telescope
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    }
  },
  -- language specific
  {
    "iamcco/markdown-preview.nvim", -- generate a mardown preview page in browser
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})
