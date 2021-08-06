" File mgmt
""""""""""""""""""""""""""""""

" (r)eload config
" nnoremap <leader>r :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>w :w<CR>

nnoremap <silent> <leader>q :bd<CR> 
nnoremap <silent> <Leader>qq  :qa!<CR>

" nnoremap <M-u> :Format<CR>

" for vimscript and lua, this is run up the file
nnoremap <leader>o :so %<CR>

""""""""""""""""""""""""""""""
" Search 
""""""""""""""""""""""""""""""


" easier to type
xmap <M-n> /
nmap <M-n> /

" clear hightligh
nnoremap <leader>n :noh<cr>


" seach word under cusor in current buffer
" remove below when I get used to use enter to search
nmap <M-m> *
vmap <M-m> *


" Put <enter> to work too! Otherwise <enter> moves to the next line, which we can
" already do by pressing the <j> key, which is a waste of keys!
" Be useful <enter> key!:
nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

" after search, center, zz and unfolder zv
map n nzzzv
map N Nzzzv


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
" nnoremap <C-c>h g^
" nnoremap <C-c>l g$
" vnoremap <C-c>h g^
" vnoremap <C-c>l g$

" try use <leader> as prefix
nnoremap <leader>h g^
nnoremap <leader>l g$
vnoremap <leader>h g^
vnoremap <leader>l g$


" Treat long lines as break lines (useful when moving around in them)
vnoremap j gj
vnoremap k gk

nnoremap j <cmd>call BetterJK('j')<CR>
nnoremap k <cmd>call BetterJK('k')<CR>


function! BetterJK(letter)
  let jump_count = v:count

"  For wrapped lines, does gj/gk
  if jump_count == 0
    call execute(printf('normal! g%s', a:letter))
    return
  endif

"  For large jumps, adds a spot on the jump list
  if jump_count > 5
    call execute("normal! m'")
  endif

  call execute(printf('normal! %d%s', jump_count, a:letter))
endfunction

" TODO: tj mapping, not working, investiage later
" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
" nnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
" nnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

""""""""""""""""""""""""""""""
" Fast edit 
""""""""""""""""""""""""""""""
inoremap jk <esc>
" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>

" use alt-d to replace .
nmap <c-x> . 
" nmap ,, . 


" nnoremap
" nnoremap
" nmap



nmap m <Plug>ReplaceWithRegisterOperator
"need to remap mark `m` to gm
" I seldom use H, M, L to move, so use it here.
nnoremap M m
xnoremap M m

" Duplicate paragraph and put down
nnoremap <Leader>cp yap<S-}>p

" Duplicate lines and put down
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv


" Quit visual mode
vnoremap v <Esc>
nnoremap <leader>v V 

" tab out
" https://www.reddit.com/r/vim/comments/6ga90i/tabbing_out_of_brackets_and_quotes/
" inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'   
inoremap <expr> <Tab> getline('.')[col('.')-1] =~? '[]>)}''"`]' ? '<Right>' : '<Tab>'   


" use shift j/k to move line down/up
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" had use J above, so I here remap join to ctrl+c prefix version
nnoremap gj J

" reamp K to leader K, S-K can open man under cursor
noremap <leader>k :execute "tab h " . expand("<cword>")<cr>


" depend on current comment plugins
function! s:commentLineDown()
  :execute "normal \<Plug>kommentary_line_default"
  :normal! m`YP``
  :execute "normal \<Plug>kommentary_line_default"
endfunction

nnoremap <M-p> :call <SID>commentLineDown()<cr>



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


nnoremap ; :
nnoremap : ;

" no more go to insert mode keep hit <Cr>
" add blank line above and below for ]sapce
" also take count, like [count]<leader>[
nnoremap <leader>]  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <leader>[  :<c-u>put =repeat(nr2char(10), v:count1)<cr>


" Copy whole text in system register
" copy all!
nnoremap ca :%y+<CR>

" paste last thing yanked, not deleted
nmap ,p "0p
nmap ,P "0P


" eaiser surrounding vim
nmap ,` ysiw`
nmap ," ysiw"
nmap ,' ysiw'
nmap ,b ysiwb 
nmap ,B ysiwB
nmap ,t ysiw<
nmap ,[ ysiw[
" don't forget you can use S in visual mode...
"

" Do NOT yank with x/s
nnoremap x "_x

" Disable dengerous/annoying mappings
" ZZ - save and close Vim
" ZQ - close Vim
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

""""""""""""""""""""""""""""""
"  remove all arrow key
""""""""""""""""""""""""""""""

"" remove all arrow key to faster my learning
" map <UP> <NOP>
" map <DOWN> <NOP>
" map <LEFT> <NOP>
" map <RIGHT> <NOP>
" inoremap <UP> <NOP>
" inoremap <DOWN> <NOP>
" inoremap <LEFT> <NOP>
" inoremap <RIGHt> <NOP>


""""""""""""""""""""""""""""""
" Tab mgmt 
""""""""""""""""""""""""""""""

nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

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



" directly go into insert mode when entering terminal mode
" directly go into normal mode when leaving terminal mode
" https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane
 function! TerminalOptions()
    silent! au BufEnter <buffer> startinsert!
    silent! au BufLeave <buffer> stopinsert!
 endfunction

au TermOpen * call TerminalOptions()





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
" nnoremap <CR> :

" Run the last command
nnoremap <m-1> :<up><esc>

" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-d>: delete char.
" cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
" cnoremap <C-f>          <Right>
" <C-b>: previous char.
" cnoremap <C-b>          <Left>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>



" nnoremap <leader><leader>r :<up>


" Start an external command with a single bang
nnoremap ! :!


" ex-mode move"
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

nnoremap <leader><leader>s :g//#<Left><Left>


" Map execute vim script this line
" nnoremap  :exec '!'.getline('.')<cr>
nnoremap <leader>x :exe getline(".")<CR>
vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>


" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" <key> + pattern + <CR> + digits + <CR> to jump to global search result
function! CCR()
    " grab the current command-line
    let cmdline = getcmdline()
    
    " does it end with '#' or 'number' or one of its abbreviations?
    if cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " press '<CR>' then ':' to enter command-line mode
        return "\<CR>:"
    else
        " press '<CR>'
        return "\<CR>"
    endif
endfunction

" map '<CR>' in command-line mode to execute the function above
cnoremap <expr> <CR> CCR()



" Put vim command output into buffer
nnoremap g! :<C-u>put=execute('')<Left><Left>

" use this to redirection ex-mode output to empty buffer in new tab
" e.g. :call TabMessage("nmap") 
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" try use below to check key mapping
" :call TabMessage("nmap") 
" :call TabMessage("nmap <leader>") 
" then you can use ctrl+o/i to back and forth the new tab
" or you don't need to go back, use 'leader q' to close the tab
nnoremap <leader><leader>h :call TabMessage("")<Left><Left>


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

