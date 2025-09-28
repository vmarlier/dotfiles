-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "sonokai" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
