-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Colorscheme
return {
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
