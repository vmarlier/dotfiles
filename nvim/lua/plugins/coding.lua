-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Coding related (LSPs, Formatters, Diagnostics)
return {
  { -- package manager for LSP, DAP, linters & formatters
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "goimports",
        "shfmt"
      },
    }
  },
  { -- extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "helm_ls",
        "gopls",
        "bashls",
        "jsonls",
        "lua_ls",
        "terraformls",
        "yamlls",
        "dockerls",
      },
    },
  },
  { -- completion engine for neovim
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- better sort completion items
      "lukas-reineke/cmp-under-comparator",
      -- nvim-cmp source for filesystem paths.
      "hrsh7th/cmp-path",
    },
    config = function()
      -- nvim-cmp setup
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
            require "cmp-under-comparator".under,
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
    end,
  },
  { -- quickstart configs for nvim LSP
    "neovim/nvim-lspconfig",
    dependencies = {
      -- nvim-cmp source for neovim's built-in language server client.
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Add additional options
      local on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local nvim_lsp = require("lspconfig")
      local util = require "lspconfig/util"

      nvim_lsp.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern { "go.work", "go.mod", ".git" },
        settings = {
          -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
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
            semanticTokens = true,
          },
        },
      }
      nvim_lsp.helm_ls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.bashls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.jsonls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.lua_ls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.terraformls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.yamlls.setup { on_attach = on_attach, capabilities = capabilities }
      nvim_lsp.dockerls.setup { on_attach = on_attach, capabilities = capabilities }

      vim.lsp.set_log_level("OFF")
    end,
  },
  { -- formatter for neovim
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
        timeout = 2000 -- ms
      },
    },
  },
  { -- a pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    "folke/trouble.nvim",
    opts = {
      auto_preview = false,
      modes = {
        lsp = {
          sections = {
            "lsp_definitions",
            "lsp_references",
            "lsp_incoming_calls",
            "lsp_outgoing_calls",
            --"lsp_implementations",
            --"lsp_type_definitions",
            --"lsp_declarations",
          },
        },
      },
    }
  },
}
