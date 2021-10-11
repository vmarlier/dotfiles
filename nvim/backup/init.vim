"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Valentin Marlier - @vmarlier
"
" Sections:
"    -> Plugins - Dein
"    -> Plugins - Settings
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> File templating
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Dein
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prerequisite: Install Dein
" #1 : curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" #2 : sh ./installer.sh ~/.cache/dein

let g:dein#install_process_timeout = 3600
let g:dein#cache_directory = $HOME . '/.cache/dein'

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " 
  call dein#add('nvim-treesitter/nvim-treesitter') "provide a simple and easy way to use the interface for tree-sitter

  " Dashboard, Helper, Term..
  call dein#add('glepnir/dashboard-nvim') "display a dashboard
  call dein#add('nvim-lua/plenary.nvim') "required for telescope
  call dein#add('nvim-telescope/telescope.nvim') "highly extendable fuzzy finder
  call dein#add('nvim-telescope/telescope-project.nvim') "manage project within Telescope
  call dein#add('folke/which-key.nvim') "displays a popup with possible key bindings
  call dein#add('akinsho/toggleterm.nvim') "terminal plugin
  " Useful Stuff
  call dein#add('lukas-reineke/indent-blankline.nvim') "indentation guides to all lines
  call dein#add('terrortylor/nvim-comment') "comment easily
  call dein#add('pseewald/vim-anyfold') "fold anything
  call dein#add('vim-scripts/align') "align stuff
  call dein#add('maxbrunsfeld/vim-yankstack') "maintains a history of previous yanks, changes and deletes
  " Git
  call dein#add('airblade/vim-gitgutter') "a vim plugin which shows a git diff in the gutter (sign column)
  call dein#add('tveskag/nvim-blame-line') "git blame in status bar or virtual text
  call dein#add('sindrets/diffview.nvim') "review all changed files for any git rev.
  " Navigation and Visual
  call dein#add('kyazdani42/nvim-tree.lua') "nvim tree
  call dein#add('glepnir/galaxyline.nvim') "statusline
  call dein#add('romgrk/barbar.nvim') "tabline plugin with re-orderable, auto-sizing..
  " Themes
  call dein#add('kyazdani42/nvim-web-devicons') "lua fork of vim-devicons
  call dein#add('joshdick/onedark.vim') "colorscheme
  
  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dashboard-nvim
let g:dashboard_default_executive = 'telescope'

" vim-anyfold
set foldlevel=99 " Open all folds
lua << EOF
local au = require('au')
au.BufRead = function()
    print(vim.bo.filetype)
end
au.BufRead = { '*', 'AnyFoldActivate' }
EOF

" vim-yankstack
let g:yankstack_yank_keys = ['y', 'd']
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

" telescope
lua << EOF
require'telescope'.load_extension('project')
EOF

" which-key.nvim
lua << EOF
require('whichkey-conf')
EOF

" galaxyline.nvim
lua << EOF
require('galaxyline-conf')
EOF

" indent-blankline.nvim
set list listchars=space:⋅
lua << EOF
require("indent_blankline").setup {
    char = "|",
    space_char_blankline = " ",
    buftype_exclude = {"terminal"}
}
EOF

" nvim-comment
lua << EOF
require('nvim_comment').setup()
EOF

" nvim-tree.nvim
lua << EOF
require('tree-conf')
EOF

" nvim-blame-line
autocmd BufEnter * EnableBlameLine

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Required settings
set nocompatible

if has('mouse_sgr')
  set ttymouse=sgr
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

" set leader key
let mapleader = ","

" Set line indication
set nu

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.DS_Store,*.git,*.svn

"Always show current position
set ruler

" Height of the command bar
set cmdheight=3

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" COLORSCHEME
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if has('termguicolors') && !has('gui_running')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

try
    colorscheme onedark
catch
endtry

set background=dark

set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowb
set noswapfile
set nowritebackup

" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File templating
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Templates
"autocmd BufNewFile *.cpp 0r ~/.vim/templates/template.cpp

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" 1 tab == 2 spaces for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Linebreak on 500 characters
set lbr
set tw=200

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing f or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" only use hjkl
map <left> <nop>              
map <down> <nop>
map <up> <nop>
map <right> <nop>

" Authorized mouse scrolling
set mouse=a

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Managing windows
map <leader>q :quit<cr>
map <leader>s :split<cr>
map <leader>v :vsplit<cr>

" Managind buffers
map <leader>n :bnext<cr>
map <leader>b :bprevious<cr>
map <leader>d :bdelete<cr>
map <leader>t :tabnew<cr> 

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes
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
