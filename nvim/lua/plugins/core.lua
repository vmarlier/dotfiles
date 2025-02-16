-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Core plugins
return {
  { -- Starter screen
    "echasnovski/mini.starter",
    version = "*",
    opts = function()
      local starter = require('mini.starter')

      local function generate_repositories_items(base_path)
        local items = {}
        local handle = io.popen('ls -d ' .. base_path .. '/*/')
        if handle then
          for dir in handle:lines() do
            -- Remove the trailing slash if it exists
            local trimmed_dir = dir:gsub("/$", "")
            -- Extract the repository name from the full path
            local repo_name = trimmed_dir:match("([^/]+)$")

            if repo_name then
              local item_name = string.format("%s", repo_name)
              local item_action = string.format(
                ":lua require('mini.starter').close(); vim.cmd('cd %s'); vim.cmd('NvimTreeToggle');",
                trimmed_dir)
              table.insert(items, { name = item_name, action = item_action, section = 'Pleo' })
            end
          end
          handle:close()
        end
        return items
      end

      local pleo_repo = generate_repositories_items("~/Git/pleo")

      local config = {
        evaluate_single = true,
        items = {
          { name = "Dotfiles", action = ":lua require('mini.starter').close(); vim.cmd('cd ~/Git/valentin.marlier/dotfiles'); vim.cmd('NvimTreeToggle');", section = 'Perso' },
          pleo_repo,
          starter.sections.builtin_actions(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning('center', 'center'),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function(ev)
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          -- INFO: based on @echasnovski's recommendation (thanks a lot!!!)
          if vim.bo[ev.buf].filetype == "ministarter" then
            pcall(starter.refresh)
          end
        end,
      })
    end
  },
  { -- Highlight words matching under cursor
    "echasnovski/mini.cursorword",
    version = "*",
    opts = {},
  },
  { -- Trim space or whiteline easily
    "echasnovski/mini.trailspace",
    version = "*",
    opts = {},
  },
  { -- Custom neovim function invokable from ui
    "DanWlker/toolbox.nvim",
    opts = {
      commands = {
        {
          name = "Format Json",
          execute = function()
            vim.cmd("%!jq '.'");
          end,
          require_input = true,
        },
        {
          name = "CWD update",
          execute = function()
            vim.cmd("cd %:p:h");
            vim.cmd("pwd");
          end,
          require_input = false,
        },
        {
          name = "Trim trailing whitespaces",
          execute = function()
            require('mini.trailspace').trim()
          end,
          require_input = false,
        },
        {
          name = "Trim trailing lines",
          execute = function()
            require('mini.trailspace').trim_last_lines()
          end,
          require_input = false,
        },
        {
          name = "No Search Highlight",
          execute = function()
            vim.cmd('noh');
          end,
          require_input = false,
        },
        {
          name = "Dashboard",
          execute = function()
            vim.cmd('BufDelAll');
            require('mini.starter').open();
          end,
          require_input = false,
        },
      },
    },
  },
  { -- Nvim adaptation of the famous parsing library
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "bash", "dockerfile", "go", "gomod", "gosum", "gowork", "terraform", "hcl",
        "lua", "json", "yaml", "diff" }, -- one of "all", or a list of languages
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      autopairs = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      }
    },
  },
  { -- Terminal
    "akinsho/toggleterm.nvim",
    opts = {
      size = 15,
      direction = 'horizontal'
    },
  },
}
