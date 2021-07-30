" Below allow us to use tab to "Tab over ([{
" https://stackoverflow.com/questions/20038550/step-over-bracket-parenthesis-etc-with-tab-in-vim


" if !exists("g:out_of_expression_quick_key")
  " let g:out_of_expression_quick_key = "<Tab>"
" endif

" execute imap " . g:out_of_expression_quick_key . " <C-r>=IncreaseColNumber()<CR>"
" execute imap " . g:out_of_expression_quick_key[0] . 'S-' . g:out_of_expression_quick_key[1:] . ' <C-r>=DecreaseColNumber()<CR>'

" let s:delimiters_exp = '[\[\]{}())"' . "'" . '<>]'

" fun! IncreaseColNumber()
  " let l:colnum = col('.')
  " let l:line = getline('.')
  " if l:line[col('.') - 1:l:colnum] =~# s:delimiters_exp 
    " return "\<Right>"
  " endif
  " if g:out_of_expression_quick_key =~# "<Return>"
    " return "\<CR>"
  " endif
  " if g:out_of_expression_quick_key =~# "<Tab>"
    " return "\<Tab>"
  " endif
" endfunction

" fun! DecreaseColNumber()
  " let l:line = getline('.')
  " if l:line[col('.') - 2] =~# s:delimiters_exp
    " return "\<Left>"
  " endif
  " if g:out_of_expression_quick_key =~# "<Return>"
    " return "\<S-CR>"
  " endif
  " if g:out_of_expression_quick_key =~# "<Tab>"
    " return "\<S-Tab>"
  " endif
" endfunction
