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
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.termguicolors = true
      vim.g.sonokai_enable_italic = true
      vim.cmd.colorscheme('sonokai')
    end
  }
}
