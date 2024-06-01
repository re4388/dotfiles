" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $




" 作弊快速鍵 XD
nmap qq yiw

" remove highlight when hit enter
nmap <silent> <cr> :noh<cr><cr>

" Quickly remove search highlights
" nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed



" go back and forward 這邊我們用 原本的熱鍵，不用 vim 的
" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
" exmap back obcommand app:go-back
" nmap <C-o> :back
" exmap forward obcommand app:go-forward
" nmap <C-i> :forward


" 定義出來的可以用用 ex mode 打了，未必需要用熱鍵
exmap vsplit obcommand workspace:split-vertical
exmap split obcommand workspace:split-horizontal



" vim surround

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets
