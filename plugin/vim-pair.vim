let g:Pairs = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'" }

for key in keys(g:Pairs)
    execute 'inoremap ' . key . ' ' . key . g:Pairs[key] . '<Esc>i'
    if key != '"' && key != "'"
        execute 'inoremap ' . g:Pairs[key] . ' <C-r>=ClosePair("' . g:Pairs[key] . '")<CR>'
    end
endfor

inoremap <BS> <C-r>=RemovePair()<CR>

" TODO
" If inside pair of quotes, do not allow another type of quotes
"
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

" Move right if closing pair and cursor is already on closing pair
function! ClosePair(pressed)
    let line = getline('.')
    let col = col('.') - 1

    if index(values(g:Pairs), a:pressed) > -1
        if line[col] == a:pressed
            return "\<DEL>" . a:pressed
        end
    end
    return a:pressed
endfunction

" TODO
" If return is pressed inside brackets, insert an extra line break
" inoremap <CR> <C-r>=CreateBlock()<CR>
"
" Add pairs of quotes when characters already on line (after non whitespace
" characters)
