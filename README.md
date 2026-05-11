# dotfiles

## Requirements
- Neovim 0.12.0+

## How to use
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/vmarlier/dotfiles/main/install.sh)"
```

## Neovim

The Neovim configuration uses **native Tree-sitter support** (Neovim 0.12+) instead of the archived `nvim-treesitter` plugin. All required language parsers are installed automatically on the first run — no manual `:TSInstall` commands needed.
