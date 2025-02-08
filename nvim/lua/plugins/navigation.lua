-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- File Navigation
return {
  { -- File tree
    "nvim-tree/nvim-tree.lua",
    version = "*",
    opts = function()
      local config = {
        filters             = {
          dotfiles = false,
        },
        -- disables netrw completely
        disable_netrw       = true,
        -- hijack netrw window on startup
        hijack_netrw        = true,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab         = false,
        -- hijacks new directory buffers when they are opened.
        -- update_to_buf_dir # has been replaced by hijack_directories for now, if rollback, think about switching back to the original parameter !
        hijack_directories  = {
          -- enable the feature
          enable = true,
          -- allow to open the tree if it was previously closed
          auto_open = true,
        },
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor       = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd          = true,
        -- show lsp diagnostics in the signcolumn
        diagnostics         = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable      = false,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd  = false,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {}
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open         = {
          -- the command to run this, leaving nil should work in most cases
          cmd  = nil,
          -- the command arguments as a list
          args = {}
        },

        actions             = {
          open_file = {
            resize_window = false,
          }
        },

        view                = {
          -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
          width = 30,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = 'left',
        },
      }
      return config
    end,
    config = function(_, config)
      local tree = require("nvim-tree")
      tree.setup(config)

      local function is_modified_buffer_open(buffers)
        for _, v in pairs(buffers) do
          if v.name:match("NvimTree_") == nil then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if
              #vim.api.nvim_list_wins() == 1
              and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
              and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
          then
            vim.cmd("quit")
          end
        end,
      })
    end
  },
}
