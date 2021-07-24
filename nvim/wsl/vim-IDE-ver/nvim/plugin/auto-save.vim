
" dsiable autosave gloablly
let g:auto_save = 0
" only autosave for md file
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType vimwiki let b:auto_save = 1
augroup END
