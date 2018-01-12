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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set  noexpandtab
set smartindent
set  nu
set path+=**
set wildmenu
colorscheme codedark
let g:airline_theme = 'dark'
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
let g:tagbar_width = 20
"Next And Previous Buffer
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
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
"autocmd BufRead,BufNewFile *.html nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"JS 
"autocmd BufRead,BufNewFile *.html  nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"HTML back to basic omnifunc
"autocmd BufRead,BufNewFile *.html nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"HTML syntastic
"autocmd BufRead,BufNewFile *.html let g:syntastic_html_checkers = ['htmlhint']
"Import html model
autocmd BufNewFile *.html 0r ~/.vim/templates/template.html
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" CSS file
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
autocmd BufRead,BufNewFile *.css let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"CSS syntastic
autocmd BufRead,BufNewFile *.css let g:syntastic_css_checkers = ['csslint']
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" PHP file
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd BufRead,BufNewFile *.php let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" PHP file can contain
"HTML
"autocmd BufRead,BufNewFile *.php nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"CSS
"autocmd BufRead,BufNewFile *.php nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"SQL
"autocmd BufRead,BufNewFile *.php nnoremap <C-d> <Esc>:set dictionary+=/home/robot/.vim/dictionnary/function.sql dictionary+=/home/robot/.vim/dictionnary/keyword.sql \| let g:SuperTabDefaultCompletionType = "<c-x><c-k>"<CR>
"JS
"autocmd BufRead,BufNewFile *.php nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"PHP back to basic omnifunc
"autocmd BufRead,BufNewFile *.php nnoremap <C-p> <Esc>:setlocal omnifunc=phpcomplete#CompletePHP \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"Syntastic PHP
autocmd BufRead,BufNewFile *.php let g:syntastic_php_checkers = ['php']
" start TagBar
autocmd BufRead,BufNewFile *.php :TagbarToggle
"Import php model
autocmd BufNewFile *.php 0r ~/.vim/templates/template.php
autocmd BufRead,BufNewFile *.php set splitbelow
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" SQL file
autocmd FileType sql set dictionary+=/home/robot/.vim/dictionnary/function.sql dictionary+=/home/robot/.vim/dictionnary/keyword.sql
autocmd BufRead,BufNewFile *.sql let g:SuperTabDefaultCompletionType = "<c-x><c-k>"
"Syntastic Sql
autocmd BufRead,BufNewFile *.sql let g:syntastic_sql_checkers = ['sqlint']
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" JS file
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufRead,BufNewFile *.js let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" JS file can contain
" HTML
"autocmd BufRead,BufNewFile *.js nnoremap <C-h> <Esc>:set omnifunc=htmlcomplete#CompleteTags \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
" CSS
"autocmd BufRead,BufNewFile *.js nnoremap <C-c> <Esc>:setlocal omnifunc=csscomplete#CompleteCSS noci \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
" JS back to basic omnifunc
"autocmd BufRead,BufNewFile *.js nnoremap <C-j> <Esc>:set omnifunc=javascriptcomplete#CompleteJS \| let g:SuperTabDefaultCompletionType = "<c-x><c-o>"<CR>
"Syntastic JS
autocmd BufRead,BufNewFile *.js let g:syntastic_javascript_checkers = ['jshint']
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Cpp file
" http://www.commentcamarche.net/faq/17019-l-autocompletion-c-c-sous-vim
" http://vim.wikia.com/wiki/C%2B%2B_code_completion
autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
autocmd BufRead,BufNewFile *.cpp let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd BufRead,BufNewFile *.cpp set tags+=~/.vim/tags/cpp
autocmd BufRead,BufNewFile *.cpp set tags+=~/.vim/tags/gl
autocmd BufRead,BufNewFile *.cpp set tags+=~/.vim/tags/sdl2
autocmd BufRead,BufNewFile *.cpp set tags+=~/.vim/tags/qt4
" Compile and Run
autocmd BufRead,BufNewFile *.cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
"each time modify project do F12
autocmd BufRead,BufNewFile *.cpp noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
autocmd BufRead,BufNewFile *.cpp inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
autocmd BufRead,BufNewFile *.hpp noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
autocmd BufRead,BufNewFile *.hpp inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
"OmniCppComplete
autocmd BufRead,BufNewFile *.cpp let OmniCpp_NamespaceSearch = 1
autocmd BufRead,BufNewFile *.cpp let OmniCpp_GlobalScopeSearch = 1
autocmd BufRead,BufNewFile *.cpp let OmniCpp_ShowAccess = 1
autocmd BufRead,BufNewFile *.cpp let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
autocmd BufRead,BufNewFile *.cpp let OmniCpp_MayCompleteDot = 1 " autocomplete after .
autocmd BufRead,BufNewFile *.cpp let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
autocmd BufRead,BufNewFile *.cpp let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
autocmd BufRead,BufNewFile *.cpp let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
autocmd BufRead,BufNewFile *.cpp au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
autocmd BufRead,BufNewFile *.cpp set completeopt=menuone,menu,longest,preview
autocmd BufRead,BufNewFile *.cpp set splitbelow
" start TagBar
autocmd BufRead,BufNewFile *.cpp :TagbarToggle
"Syntastic Cpp
autocmd BufRead,BufNewFile *.cpp let g:syntastic_javascript_checkers = ['cppcheck']
"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
autocmd BufRead,BufNewFile *.cpp set splitbelow
"Import Cpp and Hpp model
autocmd BufNewFile *.cpp 0r ~/.vim/templates/template.cpp
autocmd BufNewFile *.hpp 0r ~/.vim/templates/template.hpp
autocmd BufNewFile main.cpp 0r ~/.vim/templates/template.main.cpp
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
"C# file
"Import C#
autocmd BufNewFile *.cs 0r ~/.vim/templates/template.cs
autocmd BufNewFile *.cs 0r ~/.vim/templates/template.program.cs
autocmd BufRead,BufNewFile *.cs let g:SuperTabDefaultCompletionType = 'context'
autocmd BufRead,BufNewFile *.cs let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
autocmd BufRead,BufNewFile *.cs let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
autocmd BufRead,BufNewFile *.cs let g:SuperTabClosePreviewOnPopupClose = 1
"don't autoselect first item in omnicomplete, show if only one item (for preview)
autocmd BufRead,BufNewFile *.cs set completeopt=menuone,longest,preview
"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
autocmd BufRead,BufNewFile *.cs set splitbelow
" Get Code Issues and syntax errors
autocmd BufRead,BufNewFile *.cs let g:syntastic_cs_checkers = ['mcs']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	" automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,BufWrite,TextChanged,InsertLeave *.cs SyntasticCheck
	 " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
	"show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
	"The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END

" this setting controls how long to wait (in ms) before fetching type / symbol information.
autocmd FileType cs set updatetime=400
" Remove 'Press Enter to continue' message when type information is longer than one line.
autocmd FileType cs set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
autocmd FileType cs nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
autocmd FileType cs vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
autocmd FileType cs nnoremap <leader>nm :OmniSharpRename<cr>
autocmd FileType cs nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
autocmd FileType cs command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
autocmd FileType cs nnoremap <leader>rl :OmniSharpReloadSolution<cr>
autocmd FileType cs nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
autocmd FileType cs nnoremap <leader>tp :OmniSharpAddToProject<cr>

" Start the omnisharp server for the current solution
autocmd FileType cs nnoremap <leader>ss :OmniSharpStartServer<cr>
autocmd FileType cs nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
autocmd FileType cs nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
autocmd FileType cs set hidden

" Enable snippet completion, requires completeopt-=preview
autocmd FileType cs let g:OmniSharp_want_snippet=1
" start TagBar
autocmd BufRead,BufNewFile *.cs :TagbarToggle
"""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" Syntastic
" Doc https://github.com/vim-syntastic/syntastic/blob/master/doc/syntastic-checkers.txt
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"""""""""""""""""""""""""""

"autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
"autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
