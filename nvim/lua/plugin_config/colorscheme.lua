-----------------
-- Colorscheme --
-----------------
require("catppuccin").setup({
  flavour = "frappe",
  styles = {
    comments = { "italic" },   -- Change the style of comments
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
})

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd [[colorscheme catppuccin]]
