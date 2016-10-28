let g:Pairs = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'" }

for key in keys(g:Pairs)
    if key != '"' && key != "'"
        execute 'inoremap ' . key . ' ' . key . g:Pairs[key] . '<Esc>i'
        execute 'inoremap ' . g:Pairs[key] . ' <C-r>=ClosePair("' . g:Pairs[key] . '")<CR>'
    else
        if key == "'"
            execute 'inoremap ' . key . ' <C-r>=CloseQuotes("' . g:Pairs[key] . '")<CR>'
        else
            execute "inoremap " . key . " <C-r>=CloseQuotes('" . g:Pairs[key] . "')<CR>"
        end
    end
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

" Closes matching quote
function! CloseQuotes(pressed)
    let line = getline('.')
    let col = col('.') - 2
    let pattern = "[\'\"]"

    " Only if no quotes on line and characters on line
    if line[0:col] !~ pattern && line[col+1:-1] !~ pattern && line =~ "[:alnum:]"
        return a:pressed . a:pressed . "\<Esc>i"
    end
    return a:pressed
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
