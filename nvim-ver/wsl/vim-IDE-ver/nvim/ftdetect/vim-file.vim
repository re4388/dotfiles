
" put this into file in auto load place
augroup auto_fold_init_vim
	au!
	au Filetype vim setlocal foldlevel=0 foldmethod=marker
augroup END
