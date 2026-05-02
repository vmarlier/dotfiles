-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Coding related (LSPs, Formatters, Diagnostics)

-- Centralized server configuration
local servers = {
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
      gopls = {
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        completeUnimported = true,
        usePlaceholders = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = false,
      },
    },
  },
  helm_ls = {
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = "yaml-language-server",
        }
      }
    }
  },
  bashls = {},
  jsonls = {},
  lua_ls = {},
  terraformls = {},
  yamlls = {},
  dockerls = {},
  marksman = {},
  -- prop tech project
  html = {},  -- Helpful for frontend work
  cssls = {}, -- For the frontend directory
  -- Core: Handles the 82% TypeScript backend and React frontend
  vtsls = {
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          parameterNames = { enabled = "all" }, -- Essential for audit: clarifies what arguments do
          variableTypes = { enabled = true },
        },
      },
      vtsls = {
        autoUseWorkspaceTsdk = true, -- Ensures it uses the project's version of TS
        experimental = { completion = { enableServerSidefuzzyMatch = true } },
      },
    },
  },
  -- Quality: Essential for the project's strict linting rules
  eslint = {
    settings = {
      workingDirectory = { mode = "auto" }, -- Handles the backend/frontend subfolders correctly
      format = true,
    },
    on_attach = function(client, bufnr)
      -- This specific command ensures ESLint fixes are applied on save via conform
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  -- Mobile: Provides IDE features for the Dart/Flutter components
  dartls = {
    settings = {
      dart = {
        completeFunctionCalls = true,
        showTodos = true, -- Helps you find technical debt in the Dart code
      },
    },
  },
  -- Data: Schema-aware completion for the banking ledger and SQL migrations
  sqls = {
    on_attach = function(client, bufnr)
      require('sqls').on_attach(client, bufnr) -- Requires 'nanotee/sqls.nvim' plugin
    end,
  },
}

return {
  { -- Mason ecosystem: package manager + lspconfig integration
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "goimports",
        "shfmt",
        -- prop tech project
        "prettierd",     -- New: Formatter for TS/JS
        "sql-formatter", -- New: Formatter for Ledger SQL
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Filter out servers that Mason doesn't manage (like dartls)
      local mason_managed_servers = {}
      for server_name, _ in pairs(servers) do
        if server_name ~= "dartls" then
          table.insert(mason_managed_servers, server_name)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = mason_managed_servers,
      })
    end,
  },

  { -- LSP + Completion setup
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-under-comparator",
      -- prop tech project
      "nanotee/sqls.nvim",
    },
    config = function()
      -- Setup completion first
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        mapping = {
          ['<UP>'] = cmp.mapping.select_prev_item(),
          ['<DOWN>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
      cmp.visible_docs()

      -- LSP setup
      local on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      -- Configure servers
      for server_name, config in pairs(servers) do
        local server_config = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, config)

        if vim.lsp.config and vim.lsp.enable then
          vim.lsp.config[server_name] = server_config
          vim.lsp.enable(server_name)
        else
          require("lspconfig")[server_name].setup(server_config)
        end
      end

      vim.highlight.priorities.semantic_tokens = 95
      vim.lsp.set_log_level("OFF")
    end,
  },

  { -- Formatting
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go                 = { "goimports", lsp_format = "first", "gofmt" },
        terraform          = { "terraform_fmt" },
        tf                 = { "terraform_fmt" },
        ["terraform_vars"] = { "terraform_fmt" },
        lua                = { lsp_format = "first" },
        json               = { lsp_format = "first" },
        -- prop tech project
        -- Fast, reliable formatting for the main TypeScript codebase
        typescript         = { "prettierd", "prettier", stop_after_first = true },
        javascript         = { "prettierd", "prettier", stop_after_first = true },
        -- Standard formatting for the Dart components
        dart               = { "dart_format" },
        -- Ensures consistent formatting for ledger SQL files
        sql                = { "sql_formatter" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        }
      },
      format_on_save = {
        timeout = 2000
      },
    },
  },

  { -- LSP navigator and Diagnostics
    "folke/trouble.nvim",
    opts = {
      auto_preview = true,
      preview = {
        scratch = true,
      },
      modes = {
        lsp = {
          sections = {
            "lsp_definitions",
            "lsp_references",
            "lsp_declarations",
            "lsp_type_definitions",
          },
        },
      },
    }
  },

  { -- Helm-specific enhancements
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    opts = {
      conceal_templates = {
        enabled = true,
      },
      indent_hints = {
        enabled = true,
        only_for_current_line = true,
      },
    },
  },

  { -- Kubernetes
    "diogo464/kubernetes.nvim",
    ft = "yaml",
    dependencies = { "nvim-lspconfig" },
    config = function()
      local kubernetes = require("kubernetes")
      kubernetes.generate_schema(function(schema_url)
        if schema_url then
          local lspconfig = require("lspconfig")
          local current_config = lspconfig.util.get_config("yamlls")
          current_config.settings.yaml.schemas[schema_url] = "*.yaml"
          vim.cmd("LspRestart yamlls")
          vim.notify("Kubernetes schema loaded for yamlls.", vim.log.levels.INFO)
        else
          vim.notify("Could not get K8s schema. Authenticate and try again.", vim.log.levels.WARN)
        end
      end)
    end,
  },

  {

  }
}
