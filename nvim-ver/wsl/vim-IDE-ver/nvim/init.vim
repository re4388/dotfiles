echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim

" just test if lua in loadeable
lua require("lsp-config")



