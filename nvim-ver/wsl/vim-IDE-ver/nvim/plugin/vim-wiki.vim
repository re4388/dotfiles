
" diable table mapping to allow I use tab as popup menu in hrsh7th-nvim-compe
let g:vimwiki_table_mappings=0

" set default vimwiki syntax to md
let g:vimwiki_list = [
          \ {'path': '/home/re4388/link/vimwiki/',
          \ 'syntax': 'markdown', 
          \ 'ext': '.md'}]


command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end