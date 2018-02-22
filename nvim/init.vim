call plug#begin()
"" basics
Plug 'lilydjwg/colorizer' 						"highlight hexacode color
Plug 'Raimondi/delimitMate' 					"auto-closing quotes, parenthesis, brackets, etc...
Plug 'ervandew/supertab' 						"active completion with tab
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pseewald/vim-anyfold'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'					"nerdtree-syntax dependency
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'	
Plug 'majutsushi/tagbar'
Plug 'peterhurford/send.vim' 					"git add, git commit, git pull, git push in vim
call plug#end()





""Plugins Settings""""""""""""""""""""""""
" supertab
set complete+=t

" vim-airline
nmap <C-Tab> <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 

" vim-anyfold
set foldlevel=0
let anyfold_activate=1

" nerdtree
map <C-t> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1 "start if vim open empty
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif "start if vim open empty
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close if nerdtree is last buffer open
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓' 
let g:NERDTreeShowHidden=1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" tagbar
let g:tagbar_width = 20





""Languages Settings""""""""""""""""""""""





""Settings""""""""""""""""""""""""""""""""
" Fundamental
set encoding=utf8
"set fileencoding=utf-8
"set fileencodings=utf-8,latin-1,latin-9
set fileformat=unix
set fileformats=unix,dos,mac
filetype on
filetype plugin on
filetype plugin indent on
syntax enable on
set syntax=on

" Useful settings
set smartindent
set autoindent
set noexpandtab			"no tab to space
set tabstop=4			"width for tab
set shiftwidth=4		"width for indent
set foldenable
set foldmethod=indent 	"folding by indent
set foldlevel=99
set ignorecase			"ignore case when searching text
set smartcase			"if searching text contains uppercase case will not be ignored
set wildmenu
set swapfile
set ttyfast
set path+=**
set nu
set hidden
set backspace=indent,eol,start

" Appearance
set number		"line number
set cursorline	"highlight cursor line
set nowrap "breakindent
colorscheme default 
set background=dark
set guifont=DroidSansMono\ Nerd\ Font\ 11

""Shortcuts"""""""""""""""""""""""""""""""
" Only use hjkl stupid
imap <left> <nop>              
imap <down> <nop>
imap <up> <nop>
imap <right> <nop>
nmap <left> <nop>
nmap <down> <nop>
nmap <up> <nop>
nmap <right> <nop>

" Change buffer
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
