# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | NPM | 4.10.1 |
| Neovim | ASDF | 0.9.5 |
| Neovim | Ruby | 0.9.1 |
| Neovim | Pip3 | 0.3.1 |

## Plugins

| Plugin |
|--------|
| align.nvim |
| bufferline.nvim |
| nvim |
| cmp-nvim-lsp |
| cmp-path |
| cmp_luasnip |
| diffview.nvim |
| gitsigns.nvim |
| indent-blankline.nvim |
| lazy.nvim |
| lazygit.nvim |
| lualine.nvim |
| LuaSnip |
| markdown-preview.nvim |
| mason-lspconfig.nvim |
| mason.nvim |
| mini.starter |
| nightfox.nvim |
| nvim-autopairs |
| nvim-blame-line |
| nvim-bufdel |
| nvim-cmp |
| nvim-lspconfig |
| nvim-notify |
| nvim-tree.lua |
| nvim-treesitter |
| nvim-web-devicons |
| plenary.nvim |
| telescope-file-browser.nvim |
| telescope-live-grep-args.nvim |
| telescope-project.nvim |
| telescope-undo.nvim |
| telescope.nvim |
| telescope_sessions_picker.nvim |
| toggleterm.nvim |
| vim-anyfold |
| vim-wordmotion |
| which-key.nvim |

## LSPs

| LSP |
|--------|
| bash-language-server |
| dockerfile-language-server |
| gopls |
| helm-ls |
| json-lsp |
| lua-language-server |
| pyright |
| terraform-ls |
| yaml-language-server |

## Directory Tree

```lua
├── README.md
├── init.lua
├── lazy-lock.json
├── lua
│   ├── au.lua
│   ├── custom
│   │   └── readme.lua
│   ├── mappings.lua
│   ├── options.lua
│   ├── plugin_config
│   │   ├── autocompletion.lua
│   │   ├── bufferline.lua
│   │   ├── colorscheme.lua
│   │   ├── gitsigns.lua
│   │   ├── indent-blankline.lua
│   │   ├── init.lua
│   │   ├── lualine.lua
│   │   ├── mini-starter.lua
│   │   ├── nvim-autopairs.lua
│   │   ├── nvim-blame-line.lua
│   │   ├── nvim-bufdel.lua
│   │   ├── nvim-notify.lua
│   │   ├── nvim-tree.lua
│   │   ├── telescope.lua
│   │   ├── toggleterm.lua
│   │   ├── tree-sitter.lua
│   │   ├── vim-anyfold.lua
│   │   └── which-key.lua
│   └── plugins.lua
└── templates
│   └── template.readme.md
```
