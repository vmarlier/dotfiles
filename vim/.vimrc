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
let g:airline_theme = 'codedark'
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
nnoremap <C-n> :bnext<CR>
" <C-p> conflict with aliases for change omnifunc
"nnoremap <C-p> :bprev<CR>
"""""""""""""""""""""""""""

""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""
" NERDTree
"
" open with C-t
map <C-t> :NERDTreeToggle<CR>
" startup if vim open without specified file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close if the only open window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" change arrow symbol
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
" file highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Supertab
" Default KeyBinds
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" HTML file
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd BufRead,BufNewFile *.html let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" → Sparkup → <C-e>
" → CloseTag:
autocmd BufRead,BufNewFile *.html  let g:closetag_filenames = ',*.html,*.xhtml,*.phtml'
autocmd BufRead,BufNewFile *.html let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
autocmd BufRead,BufNewFile *.html let g:closetag_emptyTags_caseSensitive = 1
autocmd BufRead,BufNewFile *.html let g:closetag_shortcut = '>'
autocmd BufRead,BufNewFile *.html let g:closetag_close_shortcut = '<leader>>'
" HTML file can contain 
"CSS 
autocmd BufRead,BufNewFile *.html nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"JS 
autocmd BufRead,BufNewFile *.html  nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"HTML back to basic omnifunc
autocmd BufRead,BufNewFile *.html nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" CSS file
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
autocmd BufRead,BufNewFile *.css let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" PHP file
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd BufRead,BufNewFile *.php let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" PHP file can contain
"HTML
autocmd BufRead,BufNewFile *.php nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"CSS
autocmd BufRead,BufNewFile *.php nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"SQL
autocmd BufRead,BufNewFile *.php nnoremap <C-d> <Esc>:set dictionary+=/home/robot/.vim/dictionnary/function.sql dictionary+=/home/robot/.vim/dictionnary/keyword.sql \| let g:SuperTabDefaultCompletionType = "<c-x><c-k>"<CR>
"JS
autocmd BufRead,BufNewFile *.php nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"PHP back to basic omnifunc
autocmd BufRead,BufNewFile *.php nnoremap <C-p> <Esc>:set omnifunc=phpcomplete#CompletePHP \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" SQL file
autocmd FileType sql set dictionary+=/home/robot/.vim/dictionnary/function.sql dictionary+=/home/robot/.vim/dictionnary/keyword.sql
autocmd BufRead,BufNewFile *.sql let g:SuperTabDefaultCompletionType = "<c-x><c-k>"
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" JS file
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufRead,BufNewFile *.js let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" JS file can contain
" HTML
autocmd BufRead,BufNewFile *.js nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
" CSS
autocmd BufRead,BufNewFile *.js nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
" JS back to basic omnifunc
autocmd BufRead,BufNewFile *.js nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"""""""""""""""""""""""""""
