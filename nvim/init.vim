"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Valentin Marlier - @vmarlier
"
" Sections:
"    -> Basic
"    -> Plugins - Dein
"    -> Plugins - Settings
"    -> Language Settings
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('pseewald/vim-anyfold')
	call dein#add('scrooloose/nerdtree')
	call dein#add('ryanoasis/vim-devicons')	"nerdtree-syntax dependency
	call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
	call dein#add('majutsushi/tagbar')
	call dein#add('Yggdroot/indentLine')
	call dein#add('vim-scripts/bufexplorer.zip') "Quickly and easily switch between buffers. This plugin can be opened with <leader+o>
	call dein#add('ctrlpvim/ctrlp.vim') "Fuzzy file, buffer, mru and tag finder. It's mapped to <Ctrl+F>
	call dein#add('junegunn/goyo.vim') "Distraction free <leader>z
	call dein#add('amix/vim-zenroom2') "Distraction free <leader>z
	call dein#add('vim-scripts/mru.vim') "Plugin to manage Most Recently Used (MRU) files. This plugin can be opened with <leader+f>
	call dein#add('amix/open_file_under_cursor.vim') "speak for itself, <g-f>
	call dein#add('tpope/vim-commentary') "Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion. gcu uncomments a set of adjacent commented lines.
	call dein#add('terryma/vim-multiple-cursors') "Sublime Text style multiple selections for Vim, CTRL+N is remapped to CTRL+S (due to YankRing)
	call dein#add('maxbrunsfeld/vim-yankstack') "Maintains a history of previous yanks, changes and deletes
	call dein#add('airblade/vim-gitgutter') "A Vim plugin which shows a git diff in the gutter (sign column

  " Colorscheme
	call dein#add('hauleth/blame.vim')
	call dein#add('nightsense/forgotten')
	call dein#add('exitface/synthwave.vim')
	call dein#add('joshdick/onedark.vim')
	call dein#add('vim-scripts/peaksea')

  " Linter framework
	call dein#add('w0rp/ale')
	
  " Completion framework
    call dein#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' })

  " Golang
    call dein#add('fatih/vim-go') "
    call dein#add('godoctor/godoctor.vim') " refactoring tools
    call dein#add('zchee/deoplete-go', {'build': {'unix': 'make'}})
    call dein#add('jodosha/vim-godebug') "Debugger integration via delve

  " Python
    call dein#add('deoplete-plugins/deoplete-jedi') "Python completion with deoplete

  " Terraform
    call dein#add('hashivim/vim-terraform') "basic vim/terraform integration
    call dein#add('juliosueiras/vim-terraform-completion') "terraform completion


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
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" or
"autocmd Filetype <your-filetype> AnyFoldActivate " activate for a specific filetype

"set foldlevel=0  " close all folds
" or
set foldlevel=99 " Open all folds

" nerdtree
map <leader>t :NERDTreeToggle<CR>
"autocmd StdinReadPre * let s:std_in=1 "start if vim open empty
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif "start if vim open empty
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close if nerdtree is last buffer open
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
highlight NERDTreeClosable ctermfg=11
highlight NERDTreeOpenable ctermfg=11

" tagbar
let g:tagbar_width = 20

" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
            \   'go': ['go', 'golint', 'errcheck'],
            \   'python': ['flake8', 'pylint']
            \}
let g:ale_fixers = {
            \   'go': ['gofmt', 'goimports'],
            \   'python': ['autopep8']
            \}
let g:ale_fix_on_save = 1
let b:ale_warn_about_trailing_whitespace = 0
let g:airline#extensions#ale#enabled = 1

" deoplete
let g:deoplete#enable_at_startup = 1
" deoplete.nvim recommend
set completeopt+=noselect

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

" => CTRL-P
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" => ZenCoding
" Enable all functions in all modes
let g:user_zen_mode='a'
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" => vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" godoctor
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set rtp+=~/.vim/godoctor.vim
filetype plugin indent on
syntax on

" deoplete jedi
let g:python_host_prog = "/usr/local/bin/python"
let g:python3_host_prog = "/usr/local/bin/python3"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Golang
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
"set omnifunc=syntaxcomplete#Complete
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.go 0r ~/.config/nvim/templates/template.go
  augroup END
endif

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd FileType terraform let g:SuperTabDefaultCompletionType = "<c-x><c-k>"
autocmd FileType terraform let g:deoplete#omni_patterns = {}
autocmd FileType terraform call deoplete#custom#option('omni_patterns', {
\ 'complete_method': 'omnifunc',
\ 'terraform': '[^ *\t"{=$]\w*',
\})
autocmd FileType terraform set foldlevel=0
autocmd FileType terraform call deoplete#initialize()
autocmd FileType terraform set syntax=terraform


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

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

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

" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry


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

" Disable highlight when <leader><cr> is pressed
"map <silent> <leader> :noh<cr>

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" only use hjkl
"map <left> <nop>              
"map <down> <nop>
"map <up> <nop>
"map <right> <nop>
"map <left> <nop>
"map <down> <nop>
"map <up> <nop>
"map <right> <nop>

" Authorized mouse scrolling
set mouse=a

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

"map <leader>l :bnext<cr>
"map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>l :tabnext<cr>
map <leader>n :bnext<cr>
map <leader>bc :Bclose<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

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
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

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

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
