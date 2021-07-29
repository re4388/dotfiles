echom "from nvim/ftdetect/test.vim"


" you don't need to have <cr> for runnning command
" <cr> is only for mapping
function Covert_to_CheckBox()
 :VimwikiChangeSymbolTo -
 :VimwikiToggleListItem
endfunction


" gl- is to long..use leader l
autocmd FileType vimwiki nnoremap <buffer> <leader>l :call Covert_to_CheckBox()<cr>

