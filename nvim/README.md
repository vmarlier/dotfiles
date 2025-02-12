# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
| Neovim | ASDF | 0.10.4 |
| Neovim | NPM | 5.1.0 |
| Neovim | Pip3 | Not Installed |
| Neovim | Ruby | Not Installed |

## Plugins

| Plugin | Commit Hash |
|--------|-------------|
| bufferline.nvim | 655133c |
| nvim | 4965db2 |
| cmp-nvim-lsp | 99290b3 |
| cmp-path | 91ff86c |
| cmp-under-comparator | 6857f10 |
| Comment.nvim | e30b7f2 |
| conform.nvim | 398f515 |
| copilot.lua | 30321e3 |
| CopilotChat.nvim | 804d906 |
| dressing.nvim | 7e9f10b |
| edgy.nvim | 7e8dedc |
| flash.nvim | f899265 |
| git-blame.nvim | 2883a74 |
| gitsigns.nvim | 2bc3b47 |
| hydra.nvim | 9838529 |
| lazy.nvim | f15a939 |
| lualine.nvim | f4f791f |
| mason-lspconfig.nvim | 805c31e |
| mason.nvim | e2f7f90 |
| mini.cursorword | 7d1b38a |
| mini.starter | a816f50 |
| mini.trailspace | 3a328e6 |
| multicursors.nvim | 562809a |
| neo-tree.nvim | 5d172e8 |
| nui.nvim | 53e907f |
| nvim-autopairs | 3d02855 |
| nvim-bufdel | 523d58e |
| nvim-cmp | 1250990 |
| nvim-lspconfig | 6c17f86 |
| nvim-treesitter | 6108ba7a |
| nvim-ufo | 81f5ffa |
| nvim-web-devicons | 1020869 |
| plenary.nvim | 857c5ac |
| promise-async | 119e896 |
| snacks.nvim | ec91859 |
| symbols-outline.nvim | 564ee65 |
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
| goimports |
| goimports-reviser |
| golines |
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
│   │   ├── snacks.lua
│   │   └── ui.lua
│   └── utils
│   │   ├── au.lua
│   │   ├── index.lua
│   │   └── readme.lua
```
