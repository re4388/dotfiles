" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

let g:NERDTreeWinPos = "right"
""
""
"" Color Theme setting
"" If you have vim >=8.0 or Neovim >= 0.1.5
""
" if (has("termguicolors"))
"  set termguicolors
" endif
