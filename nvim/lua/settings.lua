-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Sections:
-- -> Bug Workaround
-- -> General
-- -> VIM user interface
-- -> Colors and Fonts
-- -> Files, backups and undo
-- -> File templating
-- -> Text, tab and indent related
-- -> Visual mode related
-- -> Moving around
-- -> Cool scripts

--
local o = vim.o
local g = vim.g
local wo = vim.wo
local bo = vim.bo
--
--------------------
-- Bug Workaround --
--------------------
-- TO REMOVE ON NEXT NEOVIM RELEASE
-- Issue with the terraform-ls outputting a "E5248 Invalid character in group name"
-- Issue might come from Neovim when there is a dash into the filetype name
-- see -> https://www.reddit.com/r/neovim/comments/125gctj/e5248_invalid_character_in_group_name_with/
-- see -> https://www.reddit.com/r/neovim/comments/125gctj/e5248_invalid_character_in_group_name_with/
vim.api.nvim_exec([[
  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
]], false)

-------------
-- General --
-------------
vim.cmd('set nocompatible') -- required settings
wo.number = true -- set line indication -- Keep Both Activated if you want to keep the "Tab + r" keybind
wo.relativenumber = true -- set relative line indication -- Keep Both Activated if you want to keep the "Tab + r" keybind
o.history = 50 -- sets how many lines of history VIM has to remember
o.autoread = true -- autoread when a file is updated from outside
vim.cmd[[
filetype plugin on 
filetype indent on
]] -- enable filetype plugins/indent
g.mapleader = "," -- set leader key
vim.cmd('let g:loaded_node_provider=0') -- deactivate node provider (avoid errors on :checkhealth)
vim.cmd('let g:loaded_perl_provider=0') -- deactivate perl provider (avoid errors on :checkhealth)

------------------------
-- VIM user interface --
------------------------
o.scrolloff = 7 -- x lines to the cursor - when moving vertically using j/k
o.wildmenu = true -- activate wild menu
o.wildignore= '*.o,*~,*.pyc,*.DS_Store,*.git,*.svn' -- ignore compiled files
o.ruler = true -- always show current position
o.cmdheight = 3 -- height of the command bar
o.updatetime= 300 -- having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
vim.cmd('set shortmess+=c') -- don't pass messages to |ins-completion-menu|.
o.hid = true -- a buffer becomes hidden when it is abandoned
o.backspace = 'eol,start,indent' -- configure backspace so it acts as it should act
vim.cmd('set whichwrap+=<,>,h,l') --
o.ignorecase = true -- ignore case when searching
o.smartcase = true -- when searching try to be smart about cases 
o.hlsearch = true -- highlight search results
o.incsearch = true -- makes search act like search in modern browsers
o.lazyredraw = true -- don't redraw while executing macros (good performance config)
o.magic = true -- for regular expressions turn magic on
o.showmatch = true -- show matching brackets when text indicator is over them
o.mat= 2 -- how many tenths of a second to blink when matching brackets
o.errorbells = false -- no annoying sound on errors
o.visualbell = false -- 
o.tm = 500 --
o.foldcolumn = '1' -- add a bit extra margin to the left
o.laststatus = 2
o.completeopt = 'menuone,noselect' -- set completeopt to have a better completion experience see https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

----------------------
-- Colors and Fonts --
----------------------
vim.cmd('syntax enable') -- enable syntax highlighting
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 -- colorscheme
if vim.fn.has('termguicolors') and vim.fn.has('gui_running') == 0
then
  vim.cmd("let &t_8f = '<Esc>[38;2;%lu;%lu;%lum'")
  vim.cmd("let &t_8b = '<Esc>[48;2;%lu;%lu;%lum'")
  o.termguicolors = true
end
vim.cmd[[
try
  colorscheme tokyonight
catch
endtry
]] -- set colorscheme
o.background = 'dark' -- using dark background
vim.cmd('set t_Co=256') -- set color on 256
o.encoding = 'utf8' -- set utf8 as standard encoding
o.ffs = 'unix,mac' -- use unix as the standard filetype
o.cursorline = true -- Highlight cursor line

-----------------------------
-- Files, backups and undo --
-----------------------------
o.backup = false -- turn backup off
o.swapfile = false --
o.writebackup = false --
--o.undofile = true
--o.undodir = '$HOME/.vim_runtime/temp_dirs/undodir'

---------------------
-- File templating --
---------------------
vim.cmd('autocmd BufNewFile *.rep.md 0r ~/.config/nvim/templates/template.rep.md') -- call template my reporting template
vim.cmd('autocmd BufNewFile Readme.md 0r ~/.config/nvim/templates/template.readme.md') -- call template my reporting template

----------------------------------
-- Text, tab and indent related --
----------------------------------
o.expandtab = true -- use spaces instead of tabs
o.smarttab = true -- be smart when using tabs
o.shiftwidth = 4 -- 1 tab == 4 spaces
o.tabstop = 4 --
vim.cmd('autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab') -- 1 tab == 2 spaces for yaml files
vim.cmd('autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab') -- 1 tab == 2 spaces for yaml files
vim.cmd('autocmd FileType terraform setlocal ts=2 sts=2 sw=2 expandtab') -- 1 tab == 2 spaces for yaml files
vim.cmd('autocmd FileType tf setlocal ts=2 sts=2 sw=2 expandtab') -- 1 tab == 2 spaces for yaml files
o.lbr = true -- activate line break
o.tw = 200 -- 200 char per line
o.ai = true -- auto indent
o.si = true -- Smart indent
o.wrap = true -- Wrap lines

-------------------------
-- Visual mode related --
-------------------------
-- Visual mode pressing f or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
--vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

-------------------
-- Moving around --
-------------------
o.mouse = 'a' -- authorized mouse scrolling
local map = vim.api.nvim_set_keymap
map('n', '<left>', '<nop>', {noremap = true}) -- only use hjkl on normal mode
map('n', '<down>', '<nop>', {noremap = true}) --
map('n', '<up>', '<nop>', {noremap = true}) --
map('n', '<right>', '<nop>', {noremap = true}) --
map('v', '<left>', '<nop>', {noremap = true}) -- only use hjkl on visual mode
map('v', '<down>', '<nop>', {noremap = true}) --
map('v', '<up>', '<nop>', {noremap = true}) --
map('v', '<right>', '<nop>', {noremap = true}) --
map('i', '<left>', '<nop>', {noremap = true}) -- only use hjkl on insert mode
map('i', '<down>', '<nop>', {noremap = true}) --
map('i', '<up>', '<nop>', {noremap = true}) --
map('i', '<right>', '<nop>', {noremap = true}) --
vim.cmd[[
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
]] -- specify the behavior when switching between buffers
vim.cmd[[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]] -- return to the last edit position when opening files

-----------------
-- Cool script --
-----------------
vim.cmd[[
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.yml,*.yaml :call CleanExtraSpaces()
endif
]] -- delete trailing white space on save
