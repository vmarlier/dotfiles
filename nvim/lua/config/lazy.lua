-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin-frappe" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
