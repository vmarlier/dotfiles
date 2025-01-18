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
| Neovim | ASDF | 0.10.3 |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| bufferline.nvim | 655133c |
| nvim | f67b886 |
| cmp-nvim-lsp | 99290b3 |
| cmp-path | 91ff86c |
| cmp-under-comparator | 6857f10 |
| cmp_luasnip | 98d9cb5 |
| Comment.nvim | e30b7f2 |
| conform.nvim | 6dc21d4 |
| copilot.lua | 886ee73 |
| CopilotChat.nvim | 451d365 |
| diffview.nvim | 4516612 |
| dressing.nvim | 3a45525 |
| git-blame.nvim | 2883a74 |
| gitsigns.nvim | 817bd84 |
| lazy.nvim | d8f26ef |
| lualine.nvim | 2a5bae9 |
| LuaSnip | c9b9a22 |
| markdown-preview.nvim | a923f5f |
| mason-lspconfig.nvim | e942edf |
| mason.nvim | e2f7f90 |
| mini.cursorword | 7d1b38a |
| mini.starter | 3e0af79 |
| mini.trailspace | 3a328e6 |
| nvim-autopairs | 3d02855 |
| nvim-bufdel | 523d58e |
| nvim-cmp | 8c82d0b |
| nvim-lspconfig | 14b5a80 |
| nvim-neoclip.lua | c4ce7f6 |
| nvim-notify | a3020c2 |
| nvim-tree.lua | d529a99 |
| nvim-treesitter | 5da195ac |
| nvim-ufo | 32cb247 |
| nvim-web-devicons | aafa5c1 |
| plenary.nvim | 3707cdb |
| promise-async | 119e896 |
| sqlite.lua | b487fcc |
| telescope-live-grep-args.nvim | 649b662 |
| telescope.nvim | d909568 |
| toggleterm.nvim | e76134e |
| toolbox.nvim | 160fa04 |
| trouble.nvim | 50481f4 |
| vim-wordmotion | 81d9bd2 |
| which-key.nvim | 1f8d414 |
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
│   │   │   ├── comment.lua
│   │   │   ├── copilot.lua
│   │   │   ├── copilotchat.lua
│   │   │   ├── dressing.lua
│   │   │   ├── git-blame.lua
│   │   │   ├── gitsigns.lua
│   │   │   ├── index.lua
│   │   │   ├── lualine.lua
│   │   │   ├── mini-cursorword.lua
│   │   │   ├── mini-starter.lua
│   │   │   ├── mini-trailspace.lua
│   │   │   ├── noice.lua
│   │   │   ├── nvim-autopairs.lua
│   │   │   ├── nvim-bufdel.lua
│   │   │   ├── nvim-neoclip.lua
│   │   │   ├── nvim-notify.lua
│   │   │   ├── nvim-tree.lua
│   │   │   ├── nvim-ufo.lua
│   │   │   ├── telescope.lua
│   │   │   ├── toggleterm.lua
│   │   │   ├── toolbox.lua
│   │   │   ├── tree-sitter.lua
│   │   │   ├── trouble.lua
│   │   │   ├── which-key.lua
│   │   │   └── winbar.lua
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
