let g:Pairs = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'" }

for key in keys(g:Pairs)
    echo key
    execute 'inoremap ' . key . ' ' . key . g:Pairs[key] . '<Esc>i'
endfor

" inoremap <BS> <C-r>=RemovePair()<CR>

" TODO
" Add removal of pairs if no text inside and user removes opening of pair
" Move right if closing pair and cursor is already on closing pair
" If inside pair of quotes, do not allow another type of quotes
" If return is pressed inside brackets, insert an extra line break
" Add pairs of quotes when characters already on line

" function! s:RemovePair()
"     let line = getline('.')
"     let col = col('.')
"
"     if has_key(g:Pairs)
" endfunction

" function! s:ClosePair()
"
" endfunction
