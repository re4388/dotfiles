
" diable table mapping to allow I use tab as popup menu in hrsh7th-nvim-compe
let g:vimwiki_table_mappings=0

" set default vimwiki syntax to md
let g:vimwiki_list = [
          \ {'path': '/home/re4388/link/vimwiki/',
          \ 'syntax': 'markdown', 
          \ 'ext': '.md'}]


" Automatically update links when enter Diary Index
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end


autocmd FileType vimwiki nnoremap <buffer> <Leader>gb <Plug>VimwikiGoBackLink
" autocmd FileType vimwiki nnoremap <buffer> <bs> :VimwikiToggleListItem<cr>
" autocmd FileType vimwiki b:switch_custom_definitions = [['[ ]', '[.]', '[X]']]


" cover line to checkBox, lick <S-C-c> in simplenote
function! Cover_line_to_checkBox()
 :VimwikiChangeSymbolTo -
 :VimwikiToggleListItem
endfunction

" gl- is to long..use leader b, box
" autocmd FileType vimwiki nnoremap <buffer> <leader>b :call Cover_line_to_checkBox()<cr>
autocmd FileType vimwiki nnoremap <buffer> <bs> :call Cover_line_to_checkBox()<cr>

 
noremap <silent> <Plug>covertToList :VimwikiChangeSymbolTo -<CR>:call repeat#set("\<Plug>covertToList")<CR>
autocmd FileType vimwiki nmap <buffer> <leader>l <Plug>covertToList


" :VimwikiChangeSymbolTo -<CR>
 
" nnoremap <silent> <Plug>repatableForConvertToList :VimwikiChangeSymbolTo -
" \:call repeat#set("\<Plug>:VimwikiChangeSymbolTo -")<CR>
" autocmd FileType vimwiki nnoremap <buffer> gl- <Plug>repatableForConvertToList


" ex1
" noremap <silent> <Plug>EmptyLineAbove mmO<ESC>`m:call repeat#set("\<Plug>EmptyLineAbove")<CR>
" nmap <leader>O <Plug>EmptyLineAbove

"ex2
" nnoremap <silent> <Plug>TransposeCharacters xp:call repeat#set("\<Plug>TransposeCharacters")<CR>
" nmap cp <Plug>TransposeCharacters











