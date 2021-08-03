echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim


" lua require('commented').setup()
lua require("lsp-config")
colorscheme one


" autocmd FileType typescript let b:match_words = '\<if\>::\<else\>'
" let b:match_words = '\<if\>:\<endif\>,'
		" \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'

" let b:match_ignorecase=0
"     let b:match_words =
"      \  '<:>,' .
"      \  '<\@<=!--:-->,'.
"      \  '<\@<=?\k\+:?>,'.
"      \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
"      \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'.
"      \  '\<if\>::\<else\>'
