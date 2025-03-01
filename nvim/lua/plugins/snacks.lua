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
      explorer = { enabled = false },
      input = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      -- Smooth scrolling
      scroll = {
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
        -- faster animation when repeating scroll after delay
        animate_repeat = {
          delay = 100, -- delay in ms before using the repeat animation
          duration = { step = 5, total = 50 },
          easing = "linear",
        },
        -- what buffers to animate
        filter = function(buf)
          return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and
              vim.bo[buf].buftype ~= "terminal"
        end,
      },
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
          preset = "default"
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
