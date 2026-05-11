# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | NPM | Not Installed |
| Neovim | Ruby | Not Installed |
| Neovim | Pip3 | Not Installed |
| Neovim | ASDF | 0.12.2 |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| cmp-nvim-lsp | cbc7b02 |
| cmp-path | c642487 |
| cmp-under-comparator | 6857f10 |
| conform.nvim | dca1a19 |
| copilot.lua | 18a58c6 |
| CopilotChat.nvim | 137d3bc |
| dropbar.nvim | f0a42bd |
| flash.nvim | fcea7ff |
| gitsigns.nvim | dd3f588 |
| helm-ls.nvim | 20df435 |
| kulala.nvim | 6656c9d |
| lazy.nvim | 306a055 |
| lualine.nvim | 131a558 |
| mason-lspconfig.nvim | 51feb0a |
| mason.nvim | e54f5bf |
| mini.cursorword | a7e6062 |
| mini.starter | 8ee6ce6 |
| namu.nvim | e7afbdf |
| nvim-autopairs | 7b9923a |
| nvim-cmp | a1d5048 |
| nvim-lspconfig | 451d4ef |
| nvim-tabline | deb569d |
| nvim-tree.lua | 85d1145 |
| nvim-treesitter | 4916d659 |
| nvim-ufo | ab3eb12 |
| nvim-web-devicons | 2795c26 |
| plenary.nvim | 74b06c6 |
| promise-async | 119e896 |
| snacks.nvim | ad9ede6 |
| sonokai | b023c52 |
| sqls.nvim | dfc304f |
| telescope-fzf-native.nvim | b25b749 |
| toolbox.nvim | f2890d9 |
| trouble.nvim | bd67efe |
| vim-fugitive | 3b753cf |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 3aab214 |

## LSPs, Linters & Formatters

| LSP, Linter & Formatter |
|--------|
| bash-language-server |
| css-lsp |
| dockerfile-language-server |
| eslint-lsp |
| gopls |
| helm-ls |
| html-lsp |
| json-lsp |
| lua-language-server |
| marksman |
| sqls |
| terraform-ls |
| vtsls |
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
│   │   ├── options.lua
│   │   └── treesitter.lua
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
