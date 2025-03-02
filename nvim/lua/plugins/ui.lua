-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- UI Enhancements
return {
  { -- Devicons
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  { -- Configurable bufferline
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal",
        indicator = { style = "icon", icon = "▎" },
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          if buf.name:match('%.md') then
            return vim.fn.fnamemodify(buf.name, ':t:r')
          end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = false,
        --diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
                or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer"
          }
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thick",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'id'
      },
    },
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
        "toggleterm"
      }
    },
  },
  { -- Commenting tool
    "numToStr/Comment.nvim",
    opts = {},
  },
  { -- Highlight cursorword
    "echasnovski/mini.cursorword",
    opts = {
      delay = 100,
    }
  },
}
