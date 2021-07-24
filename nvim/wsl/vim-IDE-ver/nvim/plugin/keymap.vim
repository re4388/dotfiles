
""""""""""""""""""""""""""""""
" File mgmt
""""""""""""""""""""""""""""""

" (r)eload config
nnoremap <leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>w :w<CR>

nnoremap <silent> <leader>q :bd<CR> 
nnoremap <silent> <Leader>qq  :qa!<CR>

nnoremap <M-u> :Format<CR>

" for vimscript and lua, this is run up the file
nnoremap <leader>o :so %<CR>

""""""""""""""""""""""""""""""
" Search 
""""""""""""""""""""""""""""""

" seach word under cusor in current buffer
nnoremap <M-m> *

" easier to type
xmap <M-n> /
nmap <M-n> /

" clear hightligh
nnoremap <leader>n :noh<cr>

""""""""""""""""""""""""""""""
" move
""""""""""""""""""""""""""""""

" easier to move bracket
xmap <M-q> %
nmap <M-q> %

" Easier line-wise movement
" nnoremap gh g^
" nnoremap gl g$

" go line start and end
" try use <C-c> as prefix
nnoremap <C-c>h g^
nnoremap <C-c>l g$
vnoremap <C-c>h g^
vnoremap <C-c>l g$

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk

""""""""""""""""""""""""""""""
" Fast edit 
""""""""""""""""""""""""""""""

inoremap jk <esc>

" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>

" use alt-d to replace .
nnoremap <M-d> . 


" Duplicate paragraph and put down
nnoremap <Leader>cp yap<S-}>p

" Duplicate lines and put down
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv


" Quit visual mode
vnoremap v <Esc>
nnoremap <leader>v V 

" reamp S-K to leader K, S-K can open man under cursor
noremap <leader>k :execute "tab h " . expand("<cword>")<cr>


" use shift alt + j/k to move line up and down
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv


" Better tabbing in visual mode
vnoremap < <gv
vnoremap > >gv

" Universal opposite of J
function! BreakHere()
	s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
	call histdel("/", -1)
endfunction

nnoremap <leader>j :<C-u>call BreakHere()<CR>


" reverse visual mode u/U mapping
" I usually change from lower to upper
" this make me easier to use `vu` to change to upper case for the letter
vnoremap u U
vnoremap U u

" also, guiw make the word to upper case
" no need to hit shift
nnoremap gu gU
nnoremap gU gu



""""""""""""""""""""""""""""""
"  remove all arrow key
""""""""""""""""""""""""""""""

"" remove all arrow key to faster my learning
map <UP> <NOP>
map <DOWN> <NOP>
map <LEFT> <NOP>
map <RIGHT> <NOP>
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHt> <NOP>


""""""""""""""""""""""""""""""
" Tab mgmt 
""""""""""""""""""""""""""""""

nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> <Tab> :bn<CR>

""""""""""""""""""""""""""""""
" Terminal Mode
""""""""""""""""""""""""""""""

" nnoremap <M-y> :te<CR>
nnoremap <M-y> <Esc>:sp \| te<CR>

" use same way to switch between terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" use esc to switch to terminal normal mode
tnoremap <Esc> <C-\><C-n>
" use c-v and esc if we want esc in termninal mode
tnoremap <C-v><Esc> <Esc>

highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
""""""""""""""""""""""""""""""
" windown mgmt 
""""""""""""""""""""""""""""""

" easier to change panel
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k

"resize
nnoremap <C-Left> :vertical resize +2<cr>
nnoremap <C-Right> :vertical resize -2<cr>
nnoremap <C-Up> :resize -2<cr>
nnoremap <C-Down> :resize +2<cr>

"""""""""""""""""""""""""""""
" => ex-mode 
""""""""""""""""""""""""""""""

" Quick command mod
nnoremap <CR> :

" Start an external command with a single bang
nnoremap ! :!

" Put vim command output into buffer
nnoremap g! :<C-u>put=execute('')<Left><Left>

" ex-mode move"
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

""""""""""""""""""""""""""""""
" => Misc 
""""""""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

" Basically commandline fixes for fat fingering
cnoremap %:H %:h
cnoremap %:Q %:q

