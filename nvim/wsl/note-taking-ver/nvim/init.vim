echom "Source note-taking ver init.vim"

" always set leaderkey at front
let g:mapleader = "\<Space>"


" PLUGIN ----- {{{

call plug#begin('~/.config/plugged')
Plug '907th/vim-auto-save'
Plug 'vimwiki/vimwiki'
Plug 'cohama/lexima.vim'
Plug 'tjdevries/astronauta.nvim'

Plug 'vim-airline/vim-airline'
" Plug 'jacoborus/tender.vim'

Plug 'sonph/onehalf', { 'rtp': 'vim' }
" text object
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'kana/vim-textobj-line'
" I also modify the plugin folder to only want ii and aI(modifed to ai), the
" plugin folder is inside nvim folder, not vscode inner folder
Plug 'michaeljsmith/vim-indent-object'
" let you use ciq and use cib for both [ and { 
Plug 'wellle/targets.vim'

" this allow me have a better %/<BS> function
" like jump to close bracket even in the same line
" but still there's some functionality not working in TS file
Plug 'andymass/vim-matchup'

Plug 'winston0410/commented.nvim'
" justinmk apple justinmk
" tpope apple justinmk wellle

" good utl
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/ReplaceWithRegister'
 
Plug 'romainl/vim-cool'
Plug 'unblevable/quick-scope'

" use :DD lang keyword to get doc
Plug 'romainl/vim-devdocs'
call plug#end() 
" }}}

" KEYMAP -----{{{


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
" (r)eload config


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

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk


" go line start and end
" try use <C-c> as prefix
nnoremap <C-c>h g^
nnoremap <C-c>l g$
vnoremap <C-c>h g^
vnoremap <C-c>l g$




""""""""""""""""""""""""""""""
" Fast edit 
"""""""""""""""""""""""""""""""

inoremap jk <esc>
" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>

" use alt-d to replace .
nmap <M-d> . 


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



"remap mark `m` to gm
nnoremap gm m
xnoremap gm m





""""""""""""""""""""""""""""""
" Terminal Mode
""""""""""""""""""""""""""""""
" faster ex mode
nnoremap <CR> :

" Start an external command with a single bang
nnoremap ! :!

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



""""""""""""""""""""""""""""""
" Tab mgmt 
""""""""""""""""""""""""""""""

nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> <Tab> :bn<CR>


" Better tabbing in visual mode
vnoremap < <gv
vnoremap > >gv

"tab out
"https://www.reddit.com/r/vim/comments/6ga90i/tabbing_out_of_brackets_and_quotes/
inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>' 
										


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


" }}}

" SETTING -----{{{

" Theme
" syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" colorscheme tender
" colorscheme gruvbox

set relativenumber
set ruler
" set syntax
set wrap
set noswapfile
set shiftwidth=2
set autoindent
set smartindent
set tabstop=2
set hidden            " Required to keep multiple buffers open multiple buffers
set clipboard=unnamed
set clipboard+=unnamedplus
set nocompatible
" this enable your after/ ...etc folder to be picked up when start up
filetype plugin on
syntax on

if (has("termguicolors"))
		set termguicolors
endif

" WSL yank support, for some reason, re4388 user don't need this
" but in ben user, it need this.. 
" I think ben is also in sudo group..
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif



" }}}

" PLUGIN SETTING -----{{{

let g:sneak#s_next = 1


nmap m <Plug>ReplaceWithRegisterOperator

" dsiable autosave gloablly
let g:auto_save = 0
" only autosave for md file
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType vimwiki let b:auto_save = 1
augroup END


" use another leader + c for non-vscode comment
lua require('commented').setup()

" TODO: move to after/plugin/wili.vim
let g:vimwiki_list = [
          \ {'path': '/mnt/c/Users/re438/Dropbox/vimwiki/',
          \ 'syntax': 'markdown', 
          \ 'ext': '.md'}]



" config for quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_max_chars=150

" andymass/vim-matchup 
" below line is to disable highlight functionalites
let g:matchup_motion_override_Npercent = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 0
let g:matchup_matchparen_insert_timeout = 0

"}}}

" AUTOCMD ----- {{{

" use fold to mgmt init.vim
augroup auto_fold_init_vim
	au!
	au Filetype vim setlocal foldlevel=0 foldmethod=marker
augroup END


" you don't need to have <cr> for runnning command
" <cr> is only for mapping
function Covert_to_CheckBox()
 :VimwikiChangeSymbolTo -
 :VimwikiToggleListItem
endfunction


" gl- is to long..use leader l
autocmd FileType vimwiki nnoremap <buffer> <leader>l :call Covert_to_CheckBox()<cr>



" }}}
