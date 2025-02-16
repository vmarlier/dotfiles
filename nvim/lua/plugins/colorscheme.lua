-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Colorscheme
return {
  --{
  --  "rjshkhr/shadow.nvim",
  --  priority = 1000,
  --  config = function()
  --    vim.opt.termguicolors = true
  --    vim.opt.background = "dark"
  --    vim.cmd.colorscheme("shadow")
  --  end,
  --},
  {
    "vmarlier/shadow.nvim",
    priority = 1000,
    branch = "custom-main",
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd.colorscheme("shadow")
    end,
  },
}
