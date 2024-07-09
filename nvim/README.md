# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | NPM | 5.1.0 |
| Neovim | Ruby | Not Installed |
| Neovim | Pip3 | Not Installed |
| Neovim | ASDF | 0.10.0 |

## Plugins

| Plugin |
|--------|
| bufferline.nvim |
| nvim |
| cmp-nvim-lsp |
| cmp-path |
| cmp_luasnip |
| conform.nvim |
| copilot.lua |
| CopilotChat.nvim |
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
| mini.cursorword |
| mini.starter |
| mini.trailspace |
| nvim-autopairs |
| nvim-blame-line |
| nvim-bufdel |
| nvim-cmp |
| nvim-lspconfig |
| nvim-neoclip.lua |
| nvim-notify |
| nvim-tree.lua |
| nvim-treesitter |
| nvim-web-devicons |
| plenary.nvim |
| sqlite.lua |
| telescope-file-browser.nvim |
| telescope-live-grep-args.nvim |
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
| goimports |
| gopls |
| helm-ls |
| json-lsp |
| lua-language-server |
| pyright |
| rust-analyzer |
| shfmt |
| terraform-ls |
| yaml-language-server |

## Directory Tree

```lua
├── README.md
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── index.lua
│   │   ├── mappings.lua
│   │   └── options.lua
│   ├── custom
│   │   └── readme.lua
│   ├── plugins
│   │   ├── config
│   │   │   ├── autocompletion.lua
│   │   │   ├── bufferline.lua
│   │   │   ├── colorscheme.lua
│   │   │   ├── copilot.lua
│   │   │   ├── copilotchat.lua
│   │   │   ├── gitsigns.lua
│   │   │   ├── indent-blankline.lua
│   │   │   ├── index.lua
│   │   │   ├── lualine.lua
│   │   │   ├── mini-cursorword.lua
│   │   │   ├── mini-starter.lua
│   │   │   ├── mini-trailspace.lua
│   │   │   ├── noice.lua
│   │   │   ├── nvim-autopairs.lua
│   │   │   ├── nvim-blame-line.lua
│   │   │   ├── nvim-bufdel.lua
│   │   │   ├── nvim-neoclip.lua
│   │   │   ├── nvim-notify.lua
│   │   │   ├── nvim-tree.lua
│   │   │   ├── telescope.lua
│   │   │   ├── toggleterm.lua
│   │   │   ├── tree-sitter.lua
│   │   │   ├── vim-anyfold.lua
│   │   │   └── which-key.lua
│   │   ├── index.lua
│   │   └── plugins.lua
│   └── utils
│   │   ├── au.lua
│   │   ├── index.lua
│   │   └── templates
│   │   │   └── template.readme.md
└── templates
│   └── template.readme.md
```
