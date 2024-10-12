-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Sections:
-- -> Autocmd's
-- -> General
-- -> VIM user interface
-- -> Colors and Fonts
-- -> Files, backups and undo
-- -> Text, tab and indent related
-- -> Moving around
-- -> Cool scripts

--
local o = vim.o
local g = vim.g
local wo = vim.wo
local bo = vim.bo
local utils = require('utils.index')
--

---------------
-- Autocmd's --
---------------
utils.au.nvim_create_augroups({ -- Create autocommand groups
  -- General autocommands
  General = {
    { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] }; -- allow esc
    { "TermOpen", "*", "startinsert" }; -- startinsert
    { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" }; -- no numbers
    { "TermOpen", "*", "setlocal signcolumn=no" }, -- no signcolumn
  },
  -- File templating autocommands
  FileTemplating = {
    { "BufNewFile", "*.rep.md", "0r ~/.config/nvim/templates/template.rep.md" },
    { "BufNewFile", "Readme.md", "0r ~/.config/nvim/templates/template.readme.md" },
  },
  -- Text, tab and indent related autocommands
  TextTabIndent = {
    { "FileType", "yaml", "setlocal ts=2 sts=2 sw=2 expandtab" },
    { "FileType", "lua", "setlocal ts=2 sts=2 sw=2 expandtab" },
    { "FileType", "terraform", "setlocal ts=2 sts=2 sw=2 expandtab" },
    { "FileType", "tf", "setlocal ts=2 sts=2 sw=2 expandtab" },
  },
  -- Return to the last edit position when opening files
  LastEditPosition = {
    { "BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] },
  },
  -- Clean extra spaces on save
  CleanExtraSpaces = {
    { "BufWritePre", "*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.yml,*.yaml", "call CleanExtraSpaces()" },
  },
})

-------------
-- General --
-------------
vim.cmd('set nocompatible') -- required settings
wo.number = true            -- set line indication -- Keep Both Activated if you want to keep the "Tab + r" keybind
wo.relativenumber = true    -- set relative line indication -- Keep Both Activated if you want to keep the "Tab + r" keybind
o.cursorline = true         -- Highlight cursor line
o.history = 50              -- sets how many lines of history VIM has to remember
o.autoread = true           -- autoread when a file is updated from outside
vim.cmd [[
filetype plugin on
filetype indent on
]]                                         -- enable filetype plugins/indent + signcolumn config
g.mapleader = ","                          -- set leader key
vim.cmd('let g:loaded_node_provider=0')    -- deactivate node provider (avoid errors on :checkhealth)
vim.cmd('let g:loaded_perl_provider=0')    -- deactivate perl provider (avoid errors on :checkhealth)
vim.cmd('let g:loaded_python3_provider=0') -- deactivate perl provider (avoid errors on :checkhealth)

-- For foldcolumn config check plugins/config/nvim-ufo.lua

------------------------
-- VIM user interface --
------------------------
o.scrolloff = 7                                      -- x lines to the cursor - when moving vertically using j/k
o.wildmenu = true                                    -- activate wild menu
o.wildignore = '*.o,*~,*.pyc,*.DS_Store,*.git,*.svn' -- ignore compiled files
o.ruler = true                                       -- always show current position
o.cmdheight = 2                                      -- height of the command bar
o.updatetime = 300                                   -- having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
vim.cmd('set shortmess+=c')                          -- don't pass messages to |ins-completion-menu|.
o.hid = true                                         -- a buffer becomes hidden when it is abandoned
o.backspace = 'eol,start,indent'                     -- configure backspace so it acts as it should act
vim.cmd('set whichwrap+=<,>,h,l')                    --
o.ignorecase = true                                  -- ignore case when searching
o.smartcase = true                                   -- when searching try to be smart about cases
o.hlsearch = true                                    -- highlight search results
o.incsearch = true                                   -- makes search act like search in modern browsers
o.lazyredraw = true                                  -- don't redraw while executing macros (good performance config)
o.magic = true                                       -- for regular expressions turn magic on
o.showmatch = true                                   -- show matching brackets when text indicator is over them
o.mat = 2                                            -- how many tenths of a second to blink when matching brackets
o.errorbells = false                                 -- no annoying sound on errors
o.visualbell = false                                 --
o.tm = 500                                           --
o.laststatus = 2
o.completeopt =
'menuone,noselect' -- set completeopt to have a better completion experience see https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

----------------------
-- Colors and Fonts --
----------------------
vim.cmd('syntax enable')               -- enable syntax highlighting
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 -- colorscheme
if vim.fn.has('termguicolors') and vim.fn.has('gui_running') == 0
then
  vim.cmd("let &t_8f = '<Esc>[38;2;%lu;%lu;%lum'")
  vim.cmd("let &t_8b = '<Esc>[48;2;%lu;%lu;%lum'")
  o.termguicolors = true
end
vim.cmd('set t_Co=256') -- set color on 256
o.encoding = 'utf8'     -- set utf8 as standard encoding
o.ffs = 'unix,mac'      -- use unix as the standard filetype

-----------------------------
-- Files, backups and undo --
-----------------------------
o.backup = false      -- turn backup off
o.swapfile = false    --
o.writebackup = false --
--o.undofile = true
--o.undodir = '$HOME/.vim_runtime/temp_dirs/undodir'

----------------------------------
-- Text, tab and indent related --
----------------------------------
o.expandtab = true                                                       -- use spaces instead of tabs
o.smarttab = true                                                        -- be smart when using tabs
o.shiftwidth = 4                                                         -- 1 tab == 4 spaces
o.tabstop = 4                                                            --
o.lbr = true                                                             -- activate line break
o.tw = 200                                                               -- 200 char per line
o.ai = true                                                              -- auto indent
o.si = true                                                              -- Smart indent
o.wrap = true                                                            -- Wrap lines

-------------------
-- Moving around --
-------------------
o.mouse = 'a'                                    -- authorized mouse scrolling
local map = vim.api.nvim_set_keymap
map('n', '<left>', '<nop>', { noremap = true })  -- only use hjkl on normal mode
map('n', '<down>', '<nop>', { noremap = true })  --
map('n', '<up>', '<nop>', { noremap = true })    --
map('n', '<right>', '<nop>', { noremap = true }) --
map('v', '<left>', '<nop>', { noremap = true })  -- only use hjkl on visual mode
map('v', '<down>', '<nop>', { noremap = true })  --
map('v', '<up>', '<nop>', { noremap = true })    --
map('v', '<right>', '<nop>', { noremap = true }) --
map('i', '<left>', '<nop>', { noremap = true })  -- only use hjkl on insert mode
map('i', '<down>', '<nop>', { noremap = true })  --
map('i', '<up>', '<nop>', { noremap = true })    --
map('i', '<right>', '<nop>', { noremap = true }) --
vim.cmd [[
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
]] -- specify the behavior when switching between buffers

-----------------
-- Cool script --
-----------------
vim.cmd [[
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
]] -- delete trailing white space on save
