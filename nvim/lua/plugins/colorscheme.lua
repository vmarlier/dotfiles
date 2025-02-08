-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Colorscheme
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = function()
      local config = {
        flavour = "frappe",
        styles = {
          comments = { "italic" }, -- Change the style of comments
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mason = true,
          markdown = true,
          which_key = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        }
      }
      return config
    end,
    config = function(_, config)
      local colorscheme = require("catppuccin")
      colorscheme.setup(config)

      vim.o.termguicolors = true
      vim.o.background = "dark"
      vim.cmd [[colorscheme catppuccin]]
    end,
  },
}
