-----------------
-- Tree-Sitter --
-----------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {"bash", "dockerfile", "go", "gomod", "terraform", "hcl",
    "lua", "json", "yaml"}, -- one of "all", or a list of languages
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  indent = { enable = true },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  autopairs = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
})
