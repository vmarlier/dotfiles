-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Core plugins
return {
  { -- Starter screen with dynamic repository detection
    "echasnovski/mini.starter",
    version = "*",
    opts = function()
      local starter = require('mini.starter')

      -- Extract configuration constants
      local REPO_PATHS = {
        pleo = "~/Git/pleo",
        personal = "~/Git/valentin.marlier"
      }

      local function expand_path(path)
        return vim.fn.expand(path)
      end

      local function create_repo_action(path)
        return string.format(
          ":lua require('mini.starter').close(); vim.cmd('cd %s'); vim.cmd('NvimTreeToggle');",
          path
        )
      end

      local function generate_repositories_items(base_path, section_name)
        local items = {}
        local expanded_path = expand_path(base_path)

        -- Use vim.fn.glob for better cross-platform compatibility
        local dirs = vim.fn.glob(expanded_path .. "/*", false, true)

        for _, dir in ipairs(dirs) do
          -- Check if it's actually a directory
          if vim.fn.isdirectory(dir) == 1 then
            local repo_name = vim.fn.fnamemodify(dir, ":t")

            if repo_name and repo_name ~= "" then
              table.insert(items, {
                name = repo_name,
                action = create_repo_action(dir),
                section = section_name
              })
            end
          end
        end
        return items
      end

      -- Generate items for different repository sections
      local pleo_repos = generate_repositories_items(REPO_PATHS.pleo, 'Pleo')

      -- Static personal project items
      local personal_items = {
        {
          name = "Dotfiles",
          action = create_repo_action(expand_path("~/Git/valentin.marlier/dotfiles")),
          section = 'Personal'
        },
        {
          name = "Spot",
          action = create_repo_action(expand_path("~/Git/valentin.marlier/spot")),
          section = 'Personal'
        }
      }

      local config = {
        evaluate_single = true,
        items = {
          personal_items,
          pleo_repos,
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

      -- Add startup time display
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        desc = "Display startup time in mini.starter footer",
        callback = function(ev)
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          local pad_footer = string.rep(" ", 8)

          starter.config.footer = pad_footer ..
              "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"

          if vim.bo[ev.buf].filetype == "ministarter" then
            pcall(starter.refresh)
          end
        end,
      })
    end
  },

  {                  -- Custom utility commands via UI
    "DanWlker/toolbox.nvim",
    cmd = "Toolbox", -- Lazy load on command
    keys = {
      { "<leader>ut", "<cmd>Toolbox<cr>", desc = "Open Toolbox" }
    },
    opts = {
      commands = {
        {
          name = "Git Stash with Branch Name",
          execute = function()
            if vim.fn.executable("git") ~= 1 then
              vim.notify("Git is not installed or not in PATH", vim.log.levels.ERROR)
              return
            end

            local branch_name = vim.fn.trim(vim.fn.system("git rev-parse --abbrev-ref HEAD"))
            if vim.v.shell_error ~= 0 then
              vim.notify("Not a git repository or no branch checked out.", vim.log.levels.ERROR)
              return
            end

            local output = vim.fn.system("git stash push -m '" .. branch_name .. "'")
            if vim.v.shell_error ~= 0 then
              vim.notify(output, vim.log.levels.WARN)
            else
              vim.notify("Stashed changes with message: " .. branch_name)
            end
          end,
          require_input = false,
        },
        {
          name = "Format JSON",
          execute = function()
            -- Add error handling for jq
            local has_jq = vim.fn.executable("jq") == 1
            if not has_jq then
              vim.notify("jq is not installed or not in PATH", vim.log.levels.ERROR)
              return
            end
            vim.cmd("%!jq '.'")
          end,
          require_input = false,
        },
        {
          name = "Change to Buffer Directory",
          execute = function()
            local buffer_dir = vim.fn.expand("%:p:h")
            if buffer_dir and buffer_dir ~= "" then
              vim.cmd("cd " .. buffer_dir)
              vim.notify("Changed directory to: " .. buffer_dir)
            else
              vim.notify("No buffer directory available", vim.log.levels.WARN)
            end
          end,
          require_input = false,
        },
        {
          name = "Clear Search Highlight",
          execute = function()
            vim.cmd('nohlsearch')
          end,
          require_input = false,
        },
        {
          name = "Open Dashboard",
          execute = function()
            -- Better error handling
            local ok_snacks, snacks = pcall(require, 'snacks')
            if ok_snacks and snacks.bufdelete then
              snacks.bufdelete.all()
            end

            vim.cmd('NvimTreeClose')

            local ok_starter, starter = pcall(require, 'mini.starter')
            if ok_starter then
              starter.open()
            end
          end,
          require_input = false,
        },
      },
    },
  },

  {                  -- Syntax highlighting and code parsing
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Use latest for best language support
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0,

    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,

    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    keys = {
      { "<C-space>", desc = "Increment Selection" },
      { "<bs>",      desc = "Decrement Selection", mode = "x" },
    },

    opts_extend = { "ensure_installed" },

    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false -- Better performance
      },
      indent = { enable = true },

      -- Organize language list alphabetically
      ensure_installed = {
        "bash",
        "diff",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "hcl",
        "helm",
        "json",
        "lua",
        "markdown",
        "regex",
        "terraform",
        "yaml"
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
