-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- UI Enhancements
return {
  { -- Devicons
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "seblyng/nvim-tabline",
    opts = {
      no_name = '[No Name]', -- Name for buffers with no name
      modified_icon = '', -- Icon for showing modified buffer
      close_icon = '', -- Icon for closing tab with mouse
      separator = '▌', -- Separator icon on the left side
      padding = 3, -- Prefix and suffix space
      color_all_icons = false, -- Color devicons in active and inactive tabs
      right_separator = false, -- Show right separator on the last tab
      show_index = true, -- Shows the index of tab before filename
      show_icon = true, -- Shows the devicon
      show_window_count = {
        enable = true, -- Shows the number of windows in tab after filename
        show_if_alone = false, -- do not show count if unique win in a tab
        count_unique_buf = false, -- count only win showing different buffers
        count_others = true, -- display [+x] where x is the number of other windows
        buftype_blacklist = { 'nofile' }, -- do not count if buftype among theses
      },
    }
  },
  { -- Enhance folding capabilities
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async", -- async promise library
    },
    opts = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      -- Option 2: nvim lsp as LSP client
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      -- Configuration in ./autocompletion.lua:29 as to be executed before the ufo setup
      local config = {
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = {
          default = { 'imports', 'comment' },
          json = { 'array' },
        },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
          },
        },
      }
      return config
    end,
    config = function(_, config)
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require("ufo")
      ufo.setup(config)
    end,
  },
  { -- Autopair/close symbols
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = {
        "copilot-chat",
        "snacks_terminal"
      }
    },
  },
  { -- Highlight cursorword
    "echasnovski/mini.cursorword",
    opts = {
      delay = 100,
    }
  },
}
