# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | NPM | 5.1.0 |
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |
| Neovim | ASDF | 0.10.4 |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| bufferline.nvim | 655133c |
| nvim | 4965db2 |
| cmp-nvim-lsp | 99290b3 |
| cmp-path | 91ff86c |
| cmp-under-comparator | 6857f10 |
| cmp_luasnip | 98d9cb5 |
| Comment.nvim | e30b7f2 |
| conform.nvim | 363243c |
| copilot.lua | 886ee73 |
| CopilotChat.nvim | 451d365 |
| dressing.nvim | 56ef6a9 |
| flash.nvim | f899265 |
| git-blame.nvim | 2883a74 |
| gitsigns.nvim | c23bbd3 |
| lazy.nvim | f15a939 |
| lualine.nvim | 2a5bae9 |
| LuaSnip | c9b9a22 |
| mason-lspconfig.nvim | f75e877 |
| mason.nvim | e2f7f90 |
| mini.cursorword | 7d1b38a |
| mini.starter | a816f50 |
| mini.trailspace | 3a328e6 |
| nvim-autopairs | 3d02855 |
| nvim-bufdel | 523d58e |
| nvim-cmp | 1250990 |
| nvim-lspconfig | 75edb91 |
| nvim-notify | 22f2909 |
| nvim-tree.lua | d529a99 |
| nvim-treesitter | 62911c78 |
| nvim-ufo | 81f5ffa |
| nvim-web-devicons | 4023772 |
| plenary.nvim | 3707cdb |
| promise-async | 119e896 |
| toggleterm.nvim | e76134e |
| toolbox.nvim | 160fa04 |
| trouble.nvim | 6f380b8 |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 0e76a87 |
| winbar.nvim | 13739fd |

## LSPs, Linters & Formatters

| LSP, Linter & Formatter |
|--------|
| bash-language-server |
| dockerfile-language-server |
| gofumpt |
| goimports |
| gopls |
| helm-ls |
| json-lsp |
| jsonnet-language-server |
| lua-language-server |
| pyright |
| rust-analyzer |
| shfmt |
| terraform-ls |
| tflint |
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
│   │   └── ui.lua
│   └── utils
│   │   ├── au.lua
│   │   ├── index.lua
│   │   └── readme.lua
```
