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
      indent = { enabled = false },
      input = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      toggle = { enabled = false },
      words = { enabled = false },
      explorer = { enabled = false },
      -- Notification
      notifier = {
        enabled = true,
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = "✎",
        },
        style = "minimal",
      },
      -- Picker
      picker = {
        enabled = true,
        layout = {
          preset = "ivy_split"
          --preset = "default"
        },
        sources = {
          notifier = {
            layout = { layout = { width = { min = 30, max = 0.40 } } }
          },
        }
      },
    },
  }
}
