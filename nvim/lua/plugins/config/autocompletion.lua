--------------------
-- Autocompletion --
--------------------
-- LSP servers used by Mason to be installed and for nvim_lsp configuration
local lsp_servers = { 'rust_analyzer', 'helm_ls', 'gopls', 'bashls', 'jsonls', 'lua_ls', 'terraformls', 'yamlls',
  'pyright', 'dockerls' }

local mason_ensure_installed = { 'goimports', 'shfmt' }

require("mason").setup({
  ensure_installed = mason_ensure_installed
})
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers
})

local nvim_lsp = require('lspconfig')

-- Add additional options
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- see list of lsp https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
for _, lsp in ipairs(lsp_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Levels by name: "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "OFF"
vim.lsp.set_log_level("OFF")

-- luasnip setup
local luasnip = require('luasnip') -- luasnip

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

require('conform').setup({
  formatters_by_ft = {
    ['go'] = { 'goimports' },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    }
  },
})

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.o.updatetime = 250
local utils = require('utils.index')

utils.au.nvim_create_augroups({
  -- Show line diagnostics automatically in hover window
  FloatDiagnostic = {
    { "CursorHold", "*", nil, function()
        vim.diagnostic.open_float(nil, { focus = false })
      end
    },
    { "CursorHoldI", "*", nil, function()
        vim.diagnostic.open_float(nil, { focus = false })
      end
    },
  },
  -- Format on save
  FormatOnSave = {
    { "BufWritePre", "<buffer>", nil, function(args)
        -- First, use the LSP to format the buffer
        -- vim.lsp.buf.format({ async = true })
        -- Then, use the conform module to format the buffer
        require("conform").format({ bufnr = args.buf })
      end
    },
  },
})
