---------------
-- Telescope --
---------------
local function toggle_nvim_tree()
    vim.cmd("NvimTreeToggle")
end

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy"
    },
    live_grep = {
      theme = "ivy"
    },
    grep_string = {
      theme = "ivy"
    },
    file_browser = {
      theme = "ivy"
    },
    git_files = {
      theme = "ivy"
    }
  },
})
require("telescope").load_extension("undo")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("live_grep_args")
