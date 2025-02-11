-- File Navigation
return {
  { -- File explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = false,
      enable_git_status = true,
      enable_diagnostics = true,
      mdefault_component_configs = {
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
        created = {
          enabled = false,
        },
        symlink_target = {
          enabled = false,
        },
      },
      window = {
        position = "left",
        width = 30,
      }
    }
  },
  { -- Symbols explorer, used in edgy sidebar
    'simrat39/symbols-outline.nvim',
    opts = {
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        goto_location = "<Cr>",
        focus_location = "o",
        toggle_preview = "P",
        rename_symbol = "r",
        fold = "C",
        unfold = "O",
        fold_all = "M",
        unfold_all = "R",
      },
    },
  },
  { -- Multicursors
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  }
}
