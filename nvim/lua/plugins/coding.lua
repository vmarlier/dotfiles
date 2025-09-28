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
        "shfmt"
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
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
        go                 = { "goimports", lsp_format = "first" },
        terraform          = { "terraform_fmt" },
        tf                 = { "terraform_fmt" },
        ["terraform_vars"] = { "terraform_fmt" },
        lua                = { lsp_format = "first" },
        json               = { lsp_format = "first" },
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

  { -- Diagnostics UI
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
  }
}
