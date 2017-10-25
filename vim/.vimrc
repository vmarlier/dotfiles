"""""""""""""""""""""""""""
" Basic configuration
"""""""""""""""""""""""""""
set encoding=utf-8
set nocompatible
set history=100
set undolevels=150
syntax  on
set  syntax =on
filetype  indent plugin on
set ruler
"set mouse=a
set ttyfast
set tabstop=2
set  noexpandtab	
set  nu
set path+=**
set wildmenu
colorscheme codedark
set hidden
set backspace=indent,eol,start
"Only use hjkl stupid
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"Use the buffer tabline extension of airline
let g:airline#extensions#tabline#enabled = 1
"Next And Previous Buffer
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Vim Anyfold plugin
" 
" fold on indent code
"
" to open a fold: <z-o> for one <z-O> for all
" to close a fold: <z-c> for one <z-C> for all
"
"plugin activation
set foldlevel=0
let anyfold_activate=1
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Make SuperTab plugin use tab instead <C-x> <C-k> which is the dictionnary
" completion command, in file work checker completion is enable with tab too
set complete+=t
"""""""""""""""""""""""""""
