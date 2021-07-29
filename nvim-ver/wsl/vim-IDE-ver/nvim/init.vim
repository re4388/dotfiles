echom "load wsl-v1-init.vim"


let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim


" just test if lua in loadeable
lua require("t1")
" ==========================================
"  POC
" ==========================================








" How to code function defined in lua file
" command! Scratch lua require'tool'.makeScratch()



" lua << EOF
" vim.api.nvim_set_var('sneak#s_next', 1)
"




