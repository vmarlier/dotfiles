---------------
-- NVIM-tree --
---------------
-- following options are the default
-- see doc for more info -> https://github.com/nvim-tree/nvim-tree.lua/blob/215b29bfad74518442621b9d0483a621483b066b/doc/nvim-tree-lua.txt#L163
require 'nvim-tree'.setup {
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

-- auto close nvim-tree, thanks to @rwblokzijl -> https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#rwblokzijl
-- local function tab_win_closed(winnr)
--   local api = require"nvim-tree.api"
--   local tabnr = vim.api.nvim_win_get_tabpage(winnr)
--   local bufnr = vim.api.nvim_win_get_buf(winnr)
--   local buf_info = vim.fn.getbufinfo(bufnr)[1]
--   local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
--   local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
--   if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
--     -- Close all nvim tree on :q
--     if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
--       api.tree.close()
--     end
--   else                                                      -- else closed buffer was normal buffer
--     if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
--       local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
--       if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
--         vim.schedule(function ()
--           if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
--             vim.cmd "quit"                                        -- then close all of vim
--           else                                                  -- else there are more tabs open
--             vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
--           end
--         end)
--       end
--     end
--   end
-- end
--
-- vim.api.nvim_create_autocmd("WinClosed", {
--   callback = function ()
--     local winnr = tonumber(vim.fn.expand("<amatch>"))
--     vim.schedule_wrap(tab_win_closed(winnr))
--   end,
--   nested = true
-- })
