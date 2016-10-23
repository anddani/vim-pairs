let g:Pairs = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'" }

for key in keys(g:Pairs)
    execute 'inoremap ' . key . ' ' . key . g:Pairs[key] . '<Esc>i'
endfor

inoremap <BS> <C-r>=RemovePair()<CR>

" If no text in pair (empty pair) remove whole pair
function! RemovePair()
    let line = getline('.')
    let col = col('.') - 1

    if has_key(g:Pairs, line[col-1])
        if g:Pairs[line[col-1]] == line[col]
            return "\<DEL>\<BS>"
        end
    end
    return "\<BS>"
endfunction

" TODO
" Move right if closing pair and cursor is already on closing pair
" function! ClosePair()
"
" endfunction
"
" If inside pair of quotes, do not allow another type of quotes
" If return is pressed inside brackets, insert an extra line break
" Add pairs of quotes when characters already on line
