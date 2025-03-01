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
      input = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      -- Indent guide
      indent = {
        indent = { enabled = false },
        animate = { enabled = false },
        scope = {
          enabled = true,
          priority = 200,
          char = "│",
          underline = false,
          only_current = true,
          hl = "SnacksIndent",
        },
        chunk = {
          enabled = true,
          only_current = true,
          priority = 200,
          hl = "SnacksIndent",
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "─",
          },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
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
