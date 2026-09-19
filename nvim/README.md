# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | ASDF | 0.12.2 |
| Neovim | NPM | Not Installed |
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| claudecode.nvim | 2390c6e |
| cmp-nvim-lsp | cbc7b02 |
| cmp-path | c642487 |
| cmp-under-comparator | 6857f10 |
| conform.nvim | 016802d |
| copilot.lua | b2b899f |
| CopilotChat.nvim | 004ced0 |
| dropbar.nvim | 808ba31 |
| flash.nvim | 5f0f270 |
| gitsigns.nvim | 8d79f24 |
| helm-ls.nvim | 20df435 |
| kulala.nvim | dcad056 |
| lazy.nvim | 306a055 |
| lualine.nvim | 221ce6b |
| mason-lspconfig.nvim | 49b16d6 |
| mason.nvim | 2a6940a |
| mini.cursorword | d06a70d |
| mini.starter | 0575c96 |
| namu.nvim | e7afbdf |
| nvim-autopairs | 430522f |
| nvim-cmp | 2ffe79f |
| nvim-lspconfig | ffd261c0 |
| nvim-tabline | deb569d |
| nvim-tree.lua | 531b807 |
| nvim-treesitter | 9a168f63 |
| nvim-ufo | ab3eb12 |
| nvim-web-devicons | 914decf |
| plenary.nvim | 74b06c6 |
| promise-async | 119e896 |
| snacks.nvim | 882c996 |
| sonokai | b023c52 |
| sqls.nvim | 332caa9 |
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
│   │   ├── filetype.lua
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
│   │   ├── tab_title.lua
│   │   └── worktree.lua
```
