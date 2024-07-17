local glance = require('glance')
local actions = glance.actions

require('glance').setup({
  height = 20,
  zindex = 45,

  -- By default glance will open preview "embedded" within your active window
  -- when `detached` is enabled, glance will render above all existing windows
  -- and won't be restiricted by the width of your active window
  detached = true,

  preview_win_opts = { -- Configure preview window options
    cursorline = true,
    number = true,
    wrap = true,
  },
  border = {
    enable = false, -- Show window borders. Only horizontal borders allowed
  },
  list = {
    position = 'left', -- Position of the list window 'left'|'right'
    width = 0.20, -- 33% width relative to the active window, min 0.1, max 0.5
  },
  theme = { -- This feature might not work properly in nvim-0.7.2
    enable = true, -- Will generate colors for the plugin based on your current colorscheme
    mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
  },
  hooks = {
    -- Don't open glance when there is only one result and it is located in the current buffer, open otherwise
    before_open = function(results, open, jump, method)
      local uri = vim.uri_from_bufnr(0)
      if #results == 1 then
        local target_uri = results[1].uri or results[1].targetUri

        if target_uri == uri then
          jump(results[1])
        else
          open(results)
        end
      else
        open(results)
      end
    end,
  },
})
