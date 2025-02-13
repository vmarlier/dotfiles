-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Statusline
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      -- based on https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/vscode.lua
      -- and https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
      local fn = vim.fn

      local devicons_present, devicons = pcall(require, "nvim-web-devicons")

      local function stbufnr()
        return vim.api.nvim_win_get_buf(vim.fn.win_getid())
      end

      local modes = {
        ["n"] = "NORMAL",
        ["no"] = "NORMAL (no)",
        ["nov"] = "NORMAL (nov)",
        ["noV"] = "NORMAL (noV)",
        ["noCTRL-V"] = "NORMAL",
        ["niI"] = "NORMAL i",
        ["niR"] = "NORMAL r",
        ["niV"] = "NORMAL v",
        ["nt"] = "NTERMINAL",
        ["ntT"] = "NTERMINAL (ntT)",

        ["v"] = "VISUAL",
        ["vs"] = "V-CHAR (Ctrl O)",
        ["V"] = "V-LINE",
        ["Vs"] = "V-LINE",
        [""] = "V-BLOCK",

        ["i"] = "INSERT",
        ["ic"] = "INSERT (completion)",
        ["ix"] = "INSERT completion",

        ["t"] = "TERMINAL",

        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE (Rc)",
        ["Rx"] = "REPLACEa (Rx)",
        ["Rv"] = "V-REPLACE",
        ["Rvc"] = "V-REPLACE (Rvc)",
        ["Rvx"] = "V-REPLACE (Rvx)",

        ["s"] = "SELECT",
        ["S"] = "S-LINE",
        [""] = "S-BLOCK",
        ["c"] = "COMMAND",
        ["cv"] = "COMMAND",
        ["ce"] = "COMMAND",
        ["r"] = "PROMPT",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["x"] = "CONFIRM",
        ["!"] = "SHELL",
      }

      local function mode()
        local m = vim.api.nvim_get_mode().mode
        return "%#St_Mode#" .. string.format("  %s ", modes[m])
      end

      local function file()
        local icon = "󰈚 "
        local path = vim.api.nvim_buf_get_name(stbufnr())
        local name = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]*$"

        if name ~= "Empty " then
          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end

          name = " " .. name .. " "
        end

        return icon .. name
      end

      local function git()
        if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
          return ""
        end

        if devicons_present then
          icon = devicons.get_icon("git")
        end

        return icon .. " " .. vim.b[stbufnr()].gitsigns_status_dict.head .. "  "
      end

      local function gitchanges()
        if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status or vim.o.columns < 120 then
          return ""
        end

        local git_status = vim.b[stbufnr()].gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
        local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""

        return (added .. changed .. removed) ~= "" and (added .. changed .. removed) or ""
      end

      local function lspdiag()
        if not rawget(vim, "lsp") then
          return " 󰅚 0  0"
        end

        local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
        local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

        errors = (errors and errors > 0) and ("󰅚 " .. errors .. " ") or "󰅚 0 "
        warnings = (warnings and warnings > 0) and (" " .. warnings .. " ") or " 0 "
        hints = (hints and hints > 0) and ("󰛩 " .. hints .. " ") or ""
        info = (info and info > 0) and (" " .. info .. " ") or ""

        return vim.o.columns > 140 and errors .. warnings .. hints .. info or ""
      end

      local function lsp()
        local msg = ' LSP: No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return " LSP: " .. client.name
          end
        end
        return msg
      end

      local function cwd()
        local dir_name = "%#St_Mode# 󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
        return (vim.o.columns > 85 and dir_name) or ""
      end

      local function cursor()
        local current_line = fn.line(".", vim.fn.win_getid())
        local total_line = fn.line("$", vim.fn.win_getid())
        local text = math.modf((current_line / total_line) * 100) .. tostring "%%"
        text = string.format("%4s", text)

        text = (current_line == 1 and "Top") or text
        text = (current_line == total_line and "Bot") or text

        return " " .. text
      end

      local config = {
        options = {
          icons_enabled = true,
          --theme = 'shadow',
          component_separators = '',
          section_separators = '',
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = { "NvimTree", "neo-tree", "ministarter" },
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { file },
          lualine_c = { git, gitchanges },

          lualine_x = { lspdiag },
          lualine_y = { lsp },
          lualine_z = { cwd, 'filetype', cursor }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
      return config
    end,
    config = function(_, config)
      local lualine = require("lualine")
      lualine.setup(config)
    end
  },
}
