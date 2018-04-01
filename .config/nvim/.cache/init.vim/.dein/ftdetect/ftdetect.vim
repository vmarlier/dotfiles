au BufNewFile,BufRead *.hbs set filetype=html
function! s:DetectJS()
    if getline(1) =~# '^#!.*/bin/\(env\s\+\)\?node\>'
        setfiletype javascript
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectJS()
function! s:isNode()
	let shebang = getline(1)
	if shebang =~# '^#!.*/bin/env\s\+node\>' | return 1 | en
	if shebang =~# '^#!.*/bin/node\>' | return 1 | en
	return 0
endfunction

au BufRead,BufNewFile * if !did_filetype() && s:isNode() | setf javascript | en
" Detect syntax file.
autocmd BufNewFile,BufRead *.snip,*.snippets set filetype=neosnippet
