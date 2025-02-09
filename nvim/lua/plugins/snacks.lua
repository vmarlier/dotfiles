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
      -- File Explorer
      explorer = {
        enabled = true,
        finder = "explorer",
        sort = { fields = { "sort" } },
        supports_live = true,
        tree = true,
        watch = true,
        diagnostics = true,
        diagnostics_open = false,
        git_status = true,
        git_status_open = false,
        git_untracked = true,
        follow_file = true,
        focus = "list",
        auto_close = true,
        jump = { close = false },
        formatters = {
          file = { filename_only = true },
          severity = { pos = "left" },
        },
        matcher = { sort_empty = false, fuzzy = false },
        config = function(opts)
          return require("snacks.picker.source.explorer").setup(opts)
        end,
        win = {
          list = {
            keys = {
              ["l"] = "confirm",
              ["h"] = "explorer_close", -- close directory
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open", -- open with system application
              ["P"] = "toggle_preview",
              ["y"] = "explorer_yank",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["<leader>/"] = "picker_grep",
              ["<c-t>"] = "terminal",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
            },
          },
        },
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
        sources = {
          explorer = {
            layout = { layout = { width = 30 } }
          },
          notifier = {
            layout = { layout = { width = { min = 30, max = 0.40 } } }
          },
        }
      },
      -- Terminal
      terminal = {
        win = { style = "custom_terminal" }
      },
      -- Custom styles
      styles = {
        custom_terminal = {
          height = 0.3,
          bo = {
            filetype = "snacks_terminal",
          },
          wo = {},
          keys = {
            q = "hide",
            term_normal = {
              "<esc>",
              function()
                vim.cmd("stopinsert")
              end,
              mode = "t",
              expr = true,
              desc = "exit term insert"
            },
          },
        }
      },
    },
  }
}
