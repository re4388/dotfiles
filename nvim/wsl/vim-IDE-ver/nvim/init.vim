
echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim


" put this into lua
lua require('commented').setup()
" put this into file in auto load place
augroup auto_fold_init_vim
	au!
	au Filetype vim setlocal foldlevel=0 foldmethod=marker
augroup END


lua require("t1")
" ==========================================
"  POC
" ==========================================

" How to code function defined in lua file
" command! Scratch lua require'tool'.makeScratch()

" test autoload test_folder
" call test_folder#test1#sayHello()


" lua << EOF
" vim.api.nvim_set_var('sneak#s_next', 1)
"




