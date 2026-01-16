# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | NPM | Not Installed |
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |
| Neovim | ASDF | 0.11.0 |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| amp.nvim | 3b9ad5e |
| cmp-nvim-lsp | cbc7b02 |
| cmp-path | c642487 |
| cmp-under-comparator | 6857f10 |
| conform.nvim | 8314f4c |
| copilot.lua | e78d1ff |
| CopilotChat.nvim | 9db5d3e |
| dropbar.nvim | ce20224 |
| flash.nvim | fcea7ff |
| gitsigns.nvim | 72acb69 |
| helm-ls.nvim | d6f3a8d |
| kubernetes.nvim | 44daf99 |
| kulala.nvim | ad51fbc |
| lazy.nvim | 306a055 |
| lualine.nvim | 47f91c4 |
| mason-lspconfig.nvim | e5f73a9 |
| mason.nvim | 44d1e90 |
| mini.cursorword | dda0f57 |
| mini.starter | 8ee6ce6 |
| namu.nvim | fb13c05 |
| nvim-autopairs | c2a0dd0 |
| nvim-cmp | 85bbfad |
| nvim-lspconfig | 92ee7d42 |
| nvim-tabline | deb569d |
| nvim-tree.lua | 321bc61 |
| nvim-treesitter | 42fc28ba |
| nvim-ufo | 72d54c3 |
| nvim-web-devicons | 6788013 |
| plenary.nvim | b9fd522 |
| promise-async | 119e896 |
| snacks.nvim | fe7cfe9 |
| sonokai | 5c7f88c |
| telescope-fzf-native.nvim | 6fea601 |
| toolbox.nvim | f2890d9 |
| trouble.nvim | bd67efe |
| vim-fugitive | 61b51c0 |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 3aab214 |

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
│   │   ├── tools.lua
│   │   └── ui.lua
│   └── utils
│   │   ├── au.lua
│   │   ├── expand.lua
│   │   ├── index.lua
│   │   ├── readme.lua
│   │   └── worktree.lua
```
