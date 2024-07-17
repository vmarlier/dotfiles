require("lazy").setup({
  { 'echasnovski/mini.starter',    version = '*' },
  { 'echasnovski/mini.cursorword', version = '*' },
  { 'echasnovski/mini.trailspace', version = '*' },
  'nvim-treesitter/nvim-treesitter',
  'folke/which-key.nvim',
  'zbirenbaum/copilot.lua',
  'CopilotC-Nvim/CopilotChat.nvim',
  'akinsho/toggleterm.nvim',
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
  },
  'nvim-tree/nvim-web-devicons',
  'rcarriga/nvim-notify',
  'akinsho/bufferline.nvim',
  'nvim-lualine/lualine.nvim',
  'pseewald/vim-anyfold',
  'windwp/nvim-autopairs',
  'lukas-reineke/indent-blankline.nvim',
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'kkharji/sqlite.lua',
    },
  },
  'chaoren/vim-wordmotion',
  'ojroques/nvim-bufdel',
  'lewis6991/gitsigns.nvim',
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  'f-person/git-blame.nvim',
  'sindrets/diffview.nvim',
  -- colorscheme
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'stevearc/conform.nvim',
  'dnlhc/glance.nvim',
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'JoseConseco/telescope_sessions_picker.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    }
  },
  -- language specific
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
})
