
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

" cover line to checkBox, lick <S-C-c> in simplenote
function! Cover_line_to_checkBox()
 :VimwikiChangeSymbolTo -
 :VimwikiToggleListItem
endfunction

autocmd FileType vimwiki nnoremap <buffer> <bs> :call Cover_line_to_checkBox()<cr>

" go into zen mode
autocmd FileType vimwiki nnoremap <silent> <buffer> <leader>z :Goyo<cr>::ScrollViewDisable<cr>

" make leader-l (covertToList) repeatable 
noremap <silent> <Plug>covertToList :VimwikiChangeSymbolTo -<CR>:call repeat#set("\<Plug>covertToList")<CR>
autocmd FileType vimwiki nmap <buffer> <leader>l <Plug>covertToList


" use a complex code to kind of disbale <bs>
autocmd FileType vimwiki nnoremap <buffer> <Leader>gbb <Plug>VimwikiGoBackLink

" ----- old code -------



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











