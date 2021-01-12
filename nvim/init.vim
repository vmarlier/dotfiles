"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Valentin Marlier - @vmarlier
"
" Sections:
"    -> TO DO
"    -> Cheatsheet
"    -> Basic
"    -> Plugins - Dein
"    -> Plugins - Settings
"    -> Language Settings
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> F195.154.69.122iles and backups
"    -> File templating
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TO DO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 - Multi-cursor don't work
"       Adding <Plug> when inserting with multicursor 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cheatsheet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
" <leader>+o : BufExplorer
" <leader>+f : MRU finder

" Spell Checking
" <leader>+ss : Activate spell checking

" Save
" <leader>+w : Fast saving
" :W sudo saves the file (useful for handling the permission-denied error)

" Tabs
" <leader>+t :tabnew
" <leader>+tc :tabclose
" <leader>+tn :tabnext
" <leader>+tb :tabprevious

" Buffers
" <leader>+n :bnext
" <leader>+b :bprev
" <leader>+bd :bdelete
" <leader>+ba :bufdo bd

" Windows
" <Ctrl+W>+v : Split vertically
" <Ctrl+W>+s : Split horizontally
" <Ctrl>+j : Move to the bottom window
" <Ctrl>+k : Move to the upper window
" <Ctrl>+h : Move to the left window
" <Ctrl>+l : Move to the right window

" Usefull
" gf : Open file under cursor
" gcc : (un)comment line
" gc : (un)comment selection
" Visual mode pressing f or # searches for the current selection

" View
" <leader>+z : Goyo & Zenroom
" <leader>+; : NerdTree

" Yank
" <Ctrl>+n : (Paste if not already) substitute with newer paster
" <Ctrl>+p : (Paste if not already) subsitute with older paster
" <"*yy> or <"+yy> to copy a line to your system's clipboard
" <"*p> or <"+p> to paste a line from your system's clipboard


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic
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

  " Basic plugins:
	call dein#add('Raimondi/delimitMate')   "auto-closing quotes, parenthesis, brackets, etc...
    call dein#add('ervandew/supertab') "reconfigure tab to complete
	call dein#add('vim-airline/vim-airline') "airline
	call dein#add('vim-airline/vim-airline-themes') "airline themes
	call dein#add('pseewald/vim-anyfold') "fold/unfold code
	call dein#add('scrooloose/nerdtree') "navigation tree
	call dein#add('ryanoasis/vim-devicons')	"nerdtree-syntax dependency
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight') "nerdtree-syntax dependancy
	call dein#add('Yggdroot/indentLine') "show a sign where lines are indent
	call dein#add('vim-scripts/bufexplorer.zip') "quickly and easily switch between buffers. This plugin can be opened with <leader+o>
	call dein#add('junegunn/goyo.vim') "distraction free <leader>z
	call dein#add('amix/vim-zenroom2') "distraction free <leader>z
	call dein#add('vim-scripts/mru.vim') "plugin to manage Most Recently Used (MRU) files. This plugin can be opened with <leader+f>
	call dein#add('amix/open_file_under_cursor.vim') "speak for itself, <g-f>
	call dein#add('tpope/vim-commentary') "comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion. gcu uncomments a set of adjacent commented lines.
	call dein#add('maxbrunsfeld/vim-yankstack') "maintains a history of previous yanks, changes and deletes
	call dein#add('airblade/vim-gitgutter') "a vim plugin which shows a git diff in the gutter (sign column)
    call dein#add('vim-scripts/Align') "align text easily

  " Colorscheme
	call dein#add('joshdick/onedark.vim')

  " Linter framework
	call dein#add('w0rp/ale')
	
  " Completion framework
    call dein#add('neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile'})

  " Golang
    "coc-go installed via :CocInstall coc-go stored at 

  " Terraform
    call dein#add('hashivim/vim-terraform') "terraform fmt
    call dein#add('juliosueiras/vim-terraform-completion') "terraform completion

  " Docker
  " coc: npm install -g dockerfile-language-server-nodejs


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" supertab default
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'dark'

" vim-anyfold
autocmd Filetype * AnyFoldActivate " activate for all filetypes
set foldlevel=99 " Open all folds

" nerdtree
map <leader>; :NERDTreeToggle<CR>
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif "start if vim open empty
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close if nerdtree is last buffer open
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" let g:NERDTreeDirArrowExpandable = ''
" let g:NERDTreeDirArrowCollapsible = ''
highlight NERDTreeClosable ctermfg=11
highlight NERDTreeOpenable ctermfg=11

" align
map <leader>= :Align=<CR>

" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
            \   'go': ['go', 'golint', 'errcheck'],
            \   'python': ['flake8', 'pylint'],
            \   'terraform': ['fmt', 'tflint']
            \}
" go get -u golang.org/x/lint/golint
" go get -u github.com/kisielk/errcheck
" pip3 install flake8 pylint
" brew install tflint
let g:ale_fixers = {
            \   'go': ['gofmt', 'goimports'],
            \   'python': ['autopep8'],
            \   'terraform': ['fmt', 'tflint']
            \}
" go get -u golang.org/x/tools/cmd/goimports
" pip3 install autopep8
" brew install tflint
let g:ale_fix_on_save = 1
let b:ale_warn_about_trailing_whitespace = 0
let g:airline#extensions#ale#enabled = 1

" coc.nvim
" make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" indentLine
let g:indentLine_char = '▏'

" bufExplorer plugin
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

" => MRU plugin
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

" => YankStack
let g:yankstack_yank_keys = ['y', 'd']
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

" => ZenCoding
" Enable all functions in all modes
let g:user_zen_mode='a'
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:terraform_completion_keys = 1
autocmd FileType terraform let g:SuperTabDefaultCompletionType = "<c-x><c-k>"
autocmd FileType terraform set foldlevel=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set line indication
set nu

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>:Align= <cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

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
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


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

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
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

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" 1 tab == 2 spaces for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing f or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> f :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
"map <C-space> ?

" only use hjkl
map <left> <nop>              
map <down> <nop>
map <up> <nop>
map <right> <nop>
" Authorized mouse scrolling
set mouse=a

" Managing windows
map <leader>q :quit<cr>
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Managing tabs
map <leader>t :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tb :tabprevious<cr>

" Managind buffers
map <leader>n :bnext<cr>
map <leader>b :bprevious<cr>
map <leader>bd :bdelete<cr>
map <leader>ba :bufdo bd<cr> 

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

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
