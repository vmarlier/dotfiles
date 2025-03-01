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
            vim.cmd('NvimTreeClose');
            require('mini.starter').open();
          end,
          require_input = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>",      desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "bash", "dockerfile", "go", "gomod", "gosum", "gowork", "terraform", "hcl",
        "lua", "json", "yaml", "diff", "markdown", "regex" }, -- one of "all", or a list of languages
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      autopairs = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  --{ -- Nvim adaptation of the famous parsing library
  --  "nvim-treesitter/nvim-treesitter",
  --  opts = {
  --    ensure_installed = { "bash", "dockerfile", "go", "gomod", "gosum", "gowork", "terraform", "hcl",
  --      "lua", "json", "yaml", "diff" }, -- one of "all", or a list of languages
  --    -- Install parsers synchronously (only applied to `ensure_installed`)
  --    sync_install = false,
  --    auto_install = true,
  --    indent = { enable = true },
  --    highlight = { enable = true, additional_vim_regex_highlighting = false },
  --    autopairs = { enable = true },
  --    rainbow = {
  --      enable = true,
  --      extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --      max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  --    }
  --  },
  --},
  { -- Terminal
    "akinsho/toggleterm.nvim",
    opts = {
      size = 15,
      direction = 'horizontal'
    },
  },
}
