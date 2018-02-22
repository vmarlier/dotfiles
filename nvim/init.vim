call plug#begin()
""basics
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

""color
"Plug 'goatslacker/mango', {'for': 'javascript'} "javascript colorscheme
"Plug 'modess/vim-phpcolors', {'for': 'php'}		"php colorscheme

""linter engine
Plug 'w0rp/ale'

""completion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

""completion source
Plug 'wokalski/autocomplete-flow', { 'for': 'javascript'}
Plug 'Shougo/neosnippet', { 'for': 'javascript'}
Plug 'Shougo/neosnippet-snippets', { 'for': 'javascript'}
call plug#end()





""Plugins Settings""""""""""""""""""""""""
" supertab
set complete+=t

" vim-airline
nmap <C-Tab> <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline#extensions#ale#enabled = 1

" vim-anyfold
set foldlevel=0
let anyfold_activate=1

" nerdtree
map <C-t> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1 "start if vim open empty
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif "start if vim open empty
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
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
\ 	'javascript': ['jshint'],
\}
let g:ale_fixers = {
\	'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1

" deoplete
let g:deoplete#enable_at_startup = 1

" neosnippet
let g:neosnippet#enable_completed_snippet = 1





""Settings""""""""""""""""""""""""""""""""
" fundamental
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

" useful settings
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
"set list
"set listchars=eol:¬,tab:

" appearance
set number		"line number
set cursorline	"highlight cursor line
set nowrap "breakindent
set background=dark
set guifont=monofur\ bold\ Nerd\ Font\ 11
colorscheme deus





""Shortcuts"""""""""""""""""""""""""""""""
" only use hjkl stupid
imap <left> <nop>              
imap <down> <nop>
imap <up> <nop>
imap <right> <nop>
nmap <left> <nop>
nmap <down> <nop>
nmap <up> <nop>
nmap <right> <nop>

" change buffer
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>





""Languages Settings""""""""""""""""""""""
" html
autocmd FileType html let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType html 0r ~/.config/nvim/templates/template.html

" css
autocmd FileType css let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" php
autocmd FileType php colorscheme candystripe
autocmd FileType php let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType php 0r ~/.config/nvim/templates/template.php

" javascript
autocmd FileType javascript colorscheme mango
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType javascript 0r ~/.config/nvim/templates/template.js

" c++
autocmd FileType cpp let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/template.cpp
"autocmd BufNewFile *.hpp 0r ~/.config/nvim/templates/template.hpp
"autocmd BufNewFile main.cpp 0r ~/.config/nvim/templates/template.main.cpp

" c#
autocmd FileType cs let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd BufNewFile Program.cs 0r ~/.config/nvim/templates/template.program.cs
"autocmd BufNewFile *.cs 0r ~/.config/nvim/templates/template.cs
