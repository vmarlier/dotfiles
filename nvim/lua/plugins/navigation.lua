-- File Navigation
return {
  {
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
      open_files_do_not_replace_types = { "toggleTerm", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      default_component_configs = {
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
  {
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
  }
}
