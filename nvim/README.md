# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | ASDF | 0.11.0 |
| Neovim | NPM | Not Installed |
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| cmp-nvim-lsp | bd5a7d6 |
| cmp-path | c642487 |
| cmp-under-comparator | 6857f10 |
| conform.nvim | 3bad872 |
| copilot.lua | 36c220b |
| CopilotChat.nvim | 2f3e073 |
| dropbar.nvim | 3460930 |
| flash.nvim | b68bda0 |
| gitsigns.nvim | 23ae90a |
| helm-ls.nvim | f36ecbd |
| lazy.nvim | 6c3bda4 |
| lualine.nvim | b8c2315 |
| mason-lspconfig.nvim | f760507 |
| mason.nvim | b3689a4 |
| mini.cursorword | 2a7d9ce |
| mini.starter | d803869 |
| namu.nvim | 6759df3 |
| nvim-autopairs | 23320e7 |
| nvim-cmp | b5311ab |
| nvim-lspconfig | 336b388 |
| nvim-tabline | deb569d |
| nvim-tree.lua | 321bc61 |
| nvim-treesitter | 42fc28ba |
| nvim-ufo | d31e2a9 |
| nvim-web-devicons | f6b0920 |
| plenary.nvim | b9fd522 |
| promise-async | 119e896 |
| snacks.nvim | 5e0e869 |
| sonokai | cf50520 |
| telescope-fzf-native.nvim | 1f08ed6 |
| toolbox.nvim | f2890d9 |
| trouble.nvim | f176232 |
| vim-fugitive | 61b51c0 |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 904308e |

## LSPs, Linters & Formatters

| LSP, Linter & Formatter |
|--------|
| bash-language-server |
| dockerfile-language-server |
| goimports |
| gopls |
| helm-ls |
| json-lsp |
| lua-language-server |
| marksman |
| shfmt |
| terraform-ls |
| yaml-language-server |

## Directory Tree

```lua
├── README.md
├── init.lua
├── lazy-lock.json
└── lua
│   ├── config
│   │   ├── index.lua
│   │   ├── lazy.lua
│   │   ├── mappings.lua
│   │   └── options.lua
│   ├── plugins
│   │   ├── ai.lua
│   │   ├── coding.lua
│   │   ├── colorscheme.lua
│   │   ├── core.lua
│   │   ├── git.lua
│   │   ├── lualine.lua
│   │   ├── motion.lua
│   │   ├── navigation.lua
│   │   ├── snacks.lua
│   │   └── ui.lua
│   └── utils
│   │   ├── au.lua
│   │   ├── index.lua
│   │   └── readme.lua
```
