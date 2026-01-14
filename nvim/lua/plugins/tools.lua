-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
return {
  -- REST Client Interface for Neovim
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<TAB>r",
      kulala_keymaps_prefix = "<TAB>r",
    },
  },
}
