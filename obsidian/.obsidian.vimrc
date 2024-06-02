" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
vmap j gj
vmap k gk


" I like using H and L for beginning/end of line
nmap H ^
nmap L $
 

" 作弊快速鍵 XD
nmap qq yiw
" 只 support double quote, 這裡無法使用 quote text-object 套件
nmap qs yi" 
nmap qw viwp

" remove highlight when hit enter
nmap <cr> :noh<cr><cr>

" Quickly remove search highlights
" nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed


" vimrc 此套件內建功能, Inserting Links/Hyperlinks with pasteinto
" 建立連結 / 超連結 [selected-text](paste) 特別有用
" Maps pasteinto to Alt-p
" 目前還弄不出來...
" map <A-p> :pasteinto

" go back and forward 這邊我們用 原本的熱鍵，不用 vim 的
" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
" exmap back obcommand app:go-back
" nmap <C-o> :back
" exmap forward obcommand app:go-forward
" nmap <C-i> :forward


" 定義出來的可以用用 ex mode 打了，未必需要用熱鍵
exmap vsp obcommand workspace:split-vertical
exmap sp obcommand workspace:split-horizontal

" JS 功能
" log cursor to dev console
" exmap logCursor jscommand { console.log(editor.getCursor()); }
" nmap <C-q> :logCursor




" depend on mdHelpers.js, located at /Users/re4388/Library/Mobile Documents/iCloud~md~obsidian/Documents/v0
" need to enable JS 功能
" exmap nextHeading jsfile mdHelpers.js {jumpHeading(true)}
" exmap prevHeading jsfile mdHelpers.js {jumpHeading(false)}
" nmap ]] :nextHeading
" nmap [[ :prevHeading





" vim surround

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_emphasis surround * *

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
map s* :surround_emphasis
