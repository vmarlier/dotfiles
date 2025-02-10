-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Motion
return {
  { -- Better word motion (acknowledge camelCase, snake_case..)
    "chaoren/vim-wordmotion",
  },
  { -- Navigate code
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      highlight = {
        backdrop = true,
      },
      modes = {
        -- Activate flash during search
        search = {
          enabled = false,
          highlight = { backdrop = false },
        },
        -- Activate flash with T,t,F,f
        char = {
          enabled = false,
          highlight = { backdrop = false },
        }
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
  { -- Key Mapping
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  }
}
