-- File Navigation
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<bs>', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '.', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
  { -- File tree
    "nvim-tree/nvim-tree.lua",
    version = "*",
    opts = function()
      local config = {
        on_attach          = my_on_attach,
        filters            = {
          dotfiles = false,
        },
        -- disables netrw completely
        disable_netrw      = true,
        -- hijack netrw window on startup
        hijack_netrw       = true,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab        = false,
        -- hijacks new directory buffers when they are opened.
        -- update_to_buf_dir # has been replaced by hijack_directories for now, if rollback, think about switching back to the original parameter !
        hijack_directories = {
          -- enable the feature
          enable = true,
          -- allow to open the tree if it was previously closed
          auto_open = true,
        },
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor      = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd         = true,
        -- show lsp diagnostics in the signcolumn
        diagnostics        = {
          enable = true,
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open        = {
          -- the command to run this, leaving nil should work in most cases
          cmd  = nil,
          -- the command arguments as a list
          args = {}
        },

        actions            = {
          open_file = {
            resize_window = false,
          }
        },

        view               = {
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
  {
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        colorscheme = {
          enable = false,
          options = {
            -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
            persist = true,      -- very efficient mechanism to Remember selected colorscheme
            write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          },
        },
        ui_select = { enable = false }, -- vim.ui.select() wrapper
      })
    end
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
