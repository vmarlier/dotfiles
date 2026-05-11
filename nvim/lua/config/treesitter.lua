-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Native Tree-sitter configuration for Neovim 0.12+
-- Replaces the archived nvim-treesitter plugin.

-- All parsers to ensure are installed automatically.
local ensure_installed = {
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
  "yaml",
  -- prop tech project
  -- Mobile Support: Syntax parsing for the project's Dart files
  "dart",
  -- Database: Highlighting for Ledger migrations and Kysely SQL snippets
  "sql",
  -- Config: Support for Firebase, TSConfig, and Package JSON files
  "json5",
}

-- Auto-install any missing parsers on startup (non-blocking).
local function install_missing_parsers()
  for _, lang in ipairs(ensure_installed) do
    local already_loaded = pcall(vim.treesitter.language.require_language, lang, nil, true)
    if not already_loaded then
      -- Use the native Neovim 0.12 API to install the parser.
      pcall(vim.treesitter.language.install, lang)
    end
  end
end

-- Run parser installation after the UI is ready so it doesn't block startup.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    install_missing_parsers()
  end,
})

-- Enable Tree-sitter-based syntax highlighting for every buffer.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ok = pcall(vim.treesitter.start, ev.buf)
    if not ok then
      -- Silently fall back to legacy regex highlighting when no parser is
      -- available for the current filetype.
    end
  end,
})

-- Incremental selection keymaps (replaces nvim-treesitter's incremental_selection).
-- <C-space> – init / expand selection; <bs> – shrink selection (visual mode).
vim.keymap.set({ "n", "x" }, "<C-space>", function()
  local ok, sel = pcall(require, "vim.treesitter.incremental_selection")
  if ok and sel then
    if vim.fn.mode() == "n" then
      sel.init_selection()
    else
      sel.node_incremental()
    end
  end
end, { noremap = true, silent = true, desc = "Increment Tree-sitter selection" })

vim.keymap.set("x", "<bs>", function()
  local ok, sel = pcall(require, "vim.treesitter.incremental_selection")
  if ok and sel then
    sel.node_decremental()
  end
end, { noremap = true, silent = true, desc = "Decrement Tree-sitter selection" })
