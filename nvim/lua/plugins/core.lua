-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Core plugins
return {
  { -- Starter screen with dynamic repository detection
    "echasnovski/mini.starter",
    version = "*",
    opts = function()
      local starter    = require('mini.starter')
      local expand     = require("utils.expand")

      -- Extract configuration constants
      local REPO_PATHS = {
        pleo = "~/Git/pleo",
        personal = "~/Git/valentin.marlier"
      }

      local function create_repo_action(path)
        return string.format(
          ":lua require('mini.starter').close(); vim.cmd('cd %s'); vim.cmd('NvimTreeToggle');",
          path
        )
      end

      local function get_fortune_cowsay()
        if vim.fn.executable("fortune") == 1 and vim.fn.executable("cowsay") == 1 then
          local handle = io.popen("fortune -s | cowsay")
          if handle then
            local result = handle:read("*a")
            handle:close()
            return result
          end
        end
        return ""
      end

      local function generate_repositories_items(base_path, section_name)
        local items = {}
        local expanded_path = expand.path(base_path)

        local dirs = vim.fn.glob(expanded_path .. "/*", false, true)

        for _, dir in ipairs(dirs) do
          if vim.fn.isdirectory(dir) == 1 then
            local repo_name = vim.fn.fnamemodify(dir, ":t")

            if repo_name and repo_name ~= "" and not repo_name:match("^worktree__") then
              table.insert(items, {
                name = repo_name,
                action = create_repo_action(dir),
                section = section_name,
              })
            end
          end
        end
        return items
      end

      local function generate_worktrees_items(base_path, section_name)
        local items = {}
        local expanded_path = expand.path(base_path)
        local dirs = vim.fn.glob(expanded_path .. "/worktree__*", false, true)

        for _, dir in ipairs(dirs) do
          if vim.fn.isdirectory(dir) == 1 then
            local repo_name = vim.fn.fnamemodify(dir, ":t")
            local display_name = repo_name:gsub("^worktree__", ""):gsub("__", "/")

            table.insert(items, {
              name = display_name,
              action = create_repo_action(dir),
              section = section_name,
            })
          end
        end
        return items
      end

      -- Generate items for different repository sections
      local pleo_repos = generate_repositories_items(REPO_PATHS.pleo, 'Repositories')

      local worktrees_repos = generate_worktrees_items(REPO_PATHS.pleo, 'Worktree\'s')

      -- Static personal project items
      -- Prefix them with a number to mark a difference
      local personal_items = {
        {
          name = "0. Dotfiles",
          action = create_repo_action(expand.path("~/Git/valentin.marlier/dotfiles")),
          section = 'Repositories'
        }
      }

      local action_items = {
        { name = "Lazy",          action = "Lazy",  section = "Actions" },
        { name = "Mason",         action = "Mason", section = "Actions" },
        { name = "Edit New file", action = "enew",  section = "Actions" },
        { name = "Quit",          action = "q",     section = "Actions" },
      }

      local all_repos = vim.list_extend(vim.deepcopy(personal_items), pleo_repos)

      local config = {
        header = get_fortune_cowsay(),
        evaluate_single = true,
        items = {
          all_repos,
          worktrees_repos,
          action_items,
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
          name = 'Worktree create',
          execute = function()
            require("utils.worktree").create_worktree_context()
          end,
        },
        {
          name = 'Worktrees purge',
          execute = function()
            require("utils.worktree").cleanup_all_worktrees()
          end,
        },
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
