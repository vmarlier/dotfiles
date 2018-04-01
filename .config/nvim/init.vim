" Setup dein  ---------------------------------------------------------------{{{
	if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
		call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
		call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
	endif

	set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
	call dein#begin(expand('~/.config/nvim'))
	
	""basics
	call dein#add('Shougo/dein.vim')
	call dein#add('lilydjwg/colorizer') 						"highlight hexacode color
	call dein#add('Raimondi/delimitMate') 					"auto-closing quotes, parenthesis, brackets, etc...
	call dein#add('ervandew/supertab') 							"active completion with tab
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('pseewald/vim-anyfold')
	call dein#add('scrooloose/nerdtree')
	call dein#add('ryanoasis/vim-devicons')					"nerdtree-syntax dependency
	call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
	call dein#add('majutsushi/tagbar')
	call dein#add('peterhurford/send.vim') 					"git add, git commit, git pull, git push in vim
	"call dein#add('Yggdroot/indentLine')

	""colorscheme
	call dein#add('hauleth/blame.vim')
	call dein#add('nightsense/forgotten')
	call dein#add('exitface/synthwave.vim')

	""linter framework
	call dein#add('w0rp/ale')
	
	""completion framework
	call dein#add('Shougo/deoplete.nvim')

	""nodeJS
	call dein#add('moll/vim-node', {'on_ft': ['javascript']})
	"call dein#add('ahayman/vim-nodejs-complete', {'on_ft': ['javascript']})

	""javascript
	call dein#add('wokalski/autocomplete-flow', {'on_ft': ['javascript']})
  call dein#add('Shougo/neosnippet', {'on_ft': ['javascript']})
  call dein#add('Shougo/neosnippet-snippets', {'on_ft': ['javascript']})
	call dein#add('jelera/vim-javascript-syntax', {'on_ft': ['javascript']})
	call dein#add('othree/javascript-libraries-syntax.vim', {'on_ft': ['javascript']})

	""html
	call dein#add('rstacruz/sparkup', {'on_ft': ['html']})
	call dein#add('alvan/vim-closetag', {'on_ft': ['html']})
	call dein#add('othree/html5.vim', {'on_ft': ['html']})

	""css
	call dein#add('othree/csscomplete.vim', {'on_ft': ['css']})

	""php
	call dein#add('shawncplus/phpcomplete.vim', {'on_ft': ['php']})

	if dein#check_install()
		call dein#install()
		let pluginsExist=1
	endif

	call dein#end()
" }}}

" Plugins Settings  ---------------------------------------------------------{{{

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
	let g:ale_sign_error = ''
	let g:ale_sign_warning = ''
	let g:ale_linters = {'javascript': ['jshint'], 'css' : ['csslint'], 'html' : ['htmlhint'], 'php' : ['php']}
	let g:ale_fixers = {'javascript': ['prettier'],'css': ['prettier']}
	let g:ale_fix_on_save = 1

	" deoplete
	let g:deoplete#enable_at_startup = 1

	" indentLine
	let g:indentLine_char = '▏'

	" neosnippet
	let g:neosnippet#enable_completed_snippet = 1

	" javascript-libraries-syntax
	autocmd FileType javascript let g:used_javascript_libs = 'jquery,react,angularjs'

" }}}

" Settings  -----------------------------------------------------------------{{{

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
	set tabstop=2			"width for tab
	set shiftwidth=2		"width for indent
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
	"set listchars=tab:\|

	" appearance
	set number		"line number
	set cursorline	"highlight cursor line
	set nowrap "breakindent
	set background=dark
	set guifont=monofur\ bold\ Nerd\ Font\ 11
	if has('termguicolors')
  	set termguicolors " 24-bit terminal
	else
  	let g:synthwave_termcolors=256 " 256 color mode
	endif
	colorscheme synthwave
	let g:airline_theme='synthwave'
	set splitbelow


" }}}

" Shortcuts  ----------------------------------------------------------------{{{
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

" }}}

" Languages Settings  -------------------------------------------------------{{{

	" vim
	autocmd FileType vim let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

	" html
	"autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType html let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
	autocmd Filetype html let g:closetag_filenames = "*.html"
	autocmd Filetype html let g:closetag_emptyTags_caseSensitive = 1
	autocmd Filetype html let g:closetag_shortcut = '>'
	autocmd Filetype html let g:closetag_close_shortcut = "<leader>"
	autocmd BufNewFile *.html 0r ~/.config/nvim/templates/template.html

	" css
	"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
	autocmd FileType css let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

	" php
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
	autocmd FileType php let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
	autocmd BufNewFile *.php 0r ~/.config/nvim/templates/template.php

	" javascript
	autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

	" c++
	autocmd FileType cpp let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
	autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/template.cpp
	autocmd BufNewFile *.hpp 0r ~/.config/nvim/templates/template.hpp
	autocmd BufNewFile main.cpp 0r ~/.config/nvim/templates/template.main.cpp

	" c#
	autocmd FileType cs let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
	autocmd BufNewFile Program.cs 0r ~/.config/nvim/templates/template.program.cs
	autocmd BufNewFile *.cs 0r ~/.config/nvim/templates/template.cs

" }}}
