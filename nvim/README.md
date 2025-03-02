# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |
| Neovim | ASDF | 0.10.4 |
| Neovim | NPM | 5.1.0 |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| bufferline.nvim | 655133c |
| cmp-nvim-lsp | 99290b3 |
| cmp-path | 91ff86c |
| cmp-under-comparator | 6857f10 |
| Comment.nvim | e30b7f2 |
| conform.nvim | a6f5bdb |
| copilot.lua | 30321e3 |
| CopilotChat.nvim | 791098a |
| dropbar.nvim | 807ddc7 |
| flash.nvim | 3c94266 |
| gitsigns.nvim | 4c40357 |
| lazy.nvim | 6c3bda4 |
| lualine.nvim | f4f791f |
| mason-lspconfig.nvim | 1a31f82 |
| mason.nvim | fc98833 |
| mini.cursorword | 939ffcc |
| mini.starter | a816f50 |
| namu.nvim | 3dec925 |
| nvim-autopairs | 68f0e5c |
| nvim-cmp | c273707 |
| nvim-lspconfig | a3f8422 |
| nvim-tree.lua | 6709463 |
| nvim-treesitter | c1efc9a9 |
| nvim-ufo | a52c92c |
| nvim-web-devicons | 1020869 |
| plenary.nvim | 857c5ac |
| promise-async | 119e896 |
| snacks.nvim | f970cbb |
| sonokai | 9679341 |
| telescope-fzf-native.nvim | 2a5ceff |
| toolbox.nvim | 5deeaaf |
| trouble.nvim | 85bedb7 |
| vim-fugitive | 4a745ea |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 370ec46 |

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
