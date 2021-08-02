echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim


" lua require('commented').setup()
lua require("lsp-config")
colorscheme one







function! s:commentLineDown()
  :execute "normal \<Plug>kommentary_line_default"
  :normal! m`YP``
  :execute "normal \<Plug>kommentary_line_default"
endfunction

nnoremap <M-p> :call <SID>commentLineDown()<cr>




