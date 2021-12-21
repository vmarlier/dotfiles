-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Sections:
-- -> Dashboard-NVIM
-- -> Plenary
-- -> Telescope
-- -> Telescope-Project
-- -> Tree-Sitter
-- -> Which-Key
-- -> ToggleTerm
-- -> Indent-Blankline
-- -> NVIM-Comment
-- -> VIM-Anyfold
-- -> Align
-- -> VIM-Yankstack
-- -> VIM-GitGutter
-- -> NVIM-Blame-Line
-- -> Diffview
-- -> NVIM-tree
-- -> GalaxyLine
-- -> Barbar

--------------------
-- Dashboard-NVIM --
--------------------
vim.g['dashboard_default_executive'] = 'telescope'
vim.cmd[[
let g:dashboard_custom_header =<< trim END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@
@@@@@@@@@@@'                                   `@@@@@@@@@@@@@
@@@@@@@@@@'                                     `@@@@@@@@@@@@
@@@@@@@@@'                                       `@@@@@@@@@@@
@@@@@@@@@                                         @@@@@@@@@@@
@@@@@@@@'                      n,                 `@@@@@@@@@@
@@@@@@@@                     _/ | _                @@@@@@@@@@
@@@@@@@@                    /'  `'/                @@@@@@@@@@
@@@@@@@@a                 <~    .'                a@@@@@@@@@@
@@@@@@@@@                 .'    |                 @@@@@@@@@@@
@@@@@@@@@a              _/      |                a@@@@@@@@@@@
@@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@
@@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@
@@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@
@@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@
@@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@
END
]]

-------------
-- Plenary --
-------------

---------------
-- Telescope --
---------------

-----------------
-- Tree-Sitter --
-----------------
require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  indent = { enable = true },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  autopairs = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
})

---------------
-- Which-Key --
---------------
require("which-key").setup {}

----------------
-- ToggleTerm --
----------------
require("toggleterm").setup{
  direction = 'float',
  float_opts = {
    border = 'curved',
    width = 250,
    height = 50,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

------------------
-- NVIM-Comment --
------------------
require('nvim_comment').setup()

-----------------
-- VIM-Anyfold --
-----------------
vim.o.foldlevel = 99
local au = require('au')
au.BufRead = function()
    print(vim.bo.filetype)
end
au.BufRead = { '*', 'AnyFoldActivate' }

-----------
-- Align --
-----------

-------------------
-- VIM-Yankstack --
-------------------
vim.cmd("let g:yankstack_yank_keys = ['y', 'd']")

-------------------
-- VIM-GitGutter --
-------------------

---------------------
-- NVIM-Blame-Line --
---------------------
au.BufEnter = function()
    print(vim.bo.filetype)
end
au.BufEnter = { '*', 'EnableBlameLine' }

--------------
-- Diffview --
--------------

---------------
-- NVIM-tree --
---------------
-- following options are the default
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

----------------
-- GalaxyLine --
----------------
local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      return '  '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg}
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.left[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}

gls.left[8] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[9] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.left[10] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.left[11] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
}
gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
}

gls.right[8] = {
  RainbowBlue = {
    provider = function() return ' ▊' end,
    highlight = {colors.blue,colors.bg}
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}

------------
-- Barbar --
------------
vim.g.bufferline = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    closable = true,
    clickable = true
}
