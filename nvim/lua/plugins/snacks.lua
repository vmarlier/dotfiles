-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- A collection of small QoL plugins for Neovim.
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = true },
      notifier = {
        enabled = true,
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = "✎",
        },
        width = { min = 30, max = 0.4 },
        style = "minimal",
      },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      words = { enabled = false },
    },
  }
}
