-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "shadow" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
