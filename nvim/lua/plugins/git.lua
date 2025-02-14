-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Git Integration
return {
  { -- Git integration
    "tpope/vim-fugitive",
  },
  { -- Enhance git support
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  { -- Show git blame inline
    "f-person/git-blame.nvim",
    config = function()
      local gitblame = require("gitblame")
      gitblame.setup({
        enabled = false,
      })

      vim.g.gitblame_date_format = "%r"
    end
  },
}
