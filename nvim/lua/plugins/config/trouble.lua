require('trouble').setup({
  modes = {
    lsp = {
      sections = {
        "lsp_definitions",
        "lsp_references",
        --"lsp_implementations",
        --"lsp_type_definitions",
        --"lsp_declarations",
        --"lsp_incoming_calls",
        --"lsp_outgoing_calls",
      },
    },
  },
})
