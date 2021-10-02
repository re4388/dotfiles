echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim


" lua require('commented').setup()
lua require("lsp-config")
colorscheme one

"============= abbr =============

:ab rtfm read the the fine manual

"=============  functional key try out =============

" use <C-K> and type f2...to f7 to try out
" f2: <F26>
" f3 :<F27>
" f4 :<F28>
" f5: <F29>
" f6: <F30>
" f7: <F31>

nmap <f26> yiw 
nmap <c-f4> yiw 
nmap <c-f5> yiw 
nmap <c-f6> yiw 


"============= b3nj5m1n/kommentary =============

nmap s <Plug>kommentary_motion_default
xmap s <Plug>kommentary_visual_default
nmap ss <Plug>kommentary_line_default


"============= vim-matchup =============


let g:matchup_motion_override_Npercent = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 0
let g:matchup_matchparen_insert_timeout = 0


"============= autosave plugin =============


" dsiable autosave gloablly
let g:auto_save = 0
" only autosave for md file
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType vimwiki let b:auto_save = 1
augroup END


"============= treesitter =============

" removed, no use now


"============= autocommand =============
" set folding stgy for vim file
"
" augroup auto_fold_init_vim
" 	au!
" 	au Filetype vim setlocal foldlevel=0 foldmethod=marker
" augroup END


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END


" autocmd FileType typescript let b:match_words = '\<if\>::\<else\>'
" let b:match_words = '\<if\>:\<endif\>,'
" \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'}}}


"============= POC =============


" let b:match_ignorecase=0
"     let b:match_words =
"      \  '<:>,' .
"      \  '<\@<=!--:-->,'.
"      \  '<\@<=?\k\+:?>,'.
"      \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
"      \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'.
"      \  '\<if\>::\<else\>'
