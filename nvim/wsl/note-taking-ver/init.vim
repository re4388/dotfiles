echom "Source wsl-v2 init.vim"

" always set leaderkey at front
nnoremap <SPACE> <Nop>
let mapleader=" "

" PLUGIN ----- {{{

call plug#begin('/home/ben/.config/nvim/plugged')
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
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/ReplaceWithRegister'
 
Plug 'romainl/vim-cool'
Plug 'unblevable/quick-scope'

" use :DD lang keyword to get doc
Plug 'romainl/vim-devdocs'
call plug#end() 
" }}}

" KEYMAP -----{{{


inoremap jk <esc>

" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>

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

" use alt-d to replace .
" also require vscode setting setup to send alt-d to neovim
nnoremap <M-d> . 

" Duplicate lines
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv

" Quit visual mode
vnoremap v <Esc>

" use leade v for faster go to visual line mode
nnoremap <leader>v V

" Duplicate paragraph and put down
nnoremap <Leader>cp yap<S-}>p

" ========================
" easier to move
" ========================

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" " go line start and end
" nnoremap gh g^
" nnoremap gl g$
" vnoremap gh g^
" vnoremap gl g$

" go line start and end
" try use <C-c> as prefix
nnoremap <C-c>h g^
nnoremap <C-c>l g$
vnoremap <C-c>h g^
vnoremap <C-c>l g$

" ========================
" eaier to search
" ========================

" easier to type
xmap <M-n> /
nmap <M-n> /


" To turn off highlighting until the next search
nnoremap <leader>n :noh<cr>


" find word in file under cursor
nnoremap <M-m> *

nmap m <Plug>ReplaceWithRegisterOperator

"remap mark `m` to gm
nnoremap gm m
xnoremap gm m


" Use backspace key for matching parens
nnoremap <M-q> %
xnoremap <M-q> %


" use shift j/k to move line down/up
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

" (r)eload config
nnoremap <leader>r :so $vimrc_v2<CR>
nnoremap <leader>w :w<CR>

" reamp S-K to leader K, S-K can open man under cursor
noremap <leader>k :execute "tab h " . expand("<cword>")<cr>
" faster ex mode
nnoremap <CR> :
" the counterpart is npm script in vscode
nnoremap <leader>r :so %<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>qq :qa!<cr>

" Start an external command with a single bang
nnoremap ! :!
" Simulate same TAB behavior in VSCode
nmap <Tab> :bn<CR>
nmap <S-Tab> :bp<CR>

" Better tabbing in visual mode
vnoremap < <gv
vnoremap > >gv

"tab out
"https://www.reddit.com/r/vim/comments/6ga90i/tabbing_out_of_brackets_and_quotes/
inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>' 
										

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

" let g:vimwiki_listsyms = '✗○◐●✓'
"
" function Check()
    " let l:line=getline('.')
    " let l:curs=winsaveview()
    " if l:line=~?'\s*-\s*\[\s*\].*'
        " s/\[\s*\]/[.]/
    " elseif l:line=~?'\s*-\s*\[\.\].*'
        " s/\[.\]/[x]/
    " elseif l:line=~?'\s*-\s*\[x\].*'
        " s/\[x\]/[ ]/
    " endif
    " call winrestview(l:curs)
" endfunction
" autocmd! FileType vimwiki nnoremap <buffer> <silent> - :call Check()<CR>

" augroup demo
 " autocmd!
 " autocmd FileType markdown,vimwiki nnoremap <buffer> <silent> - :call VimwikiChangeSymbolTo -<CR>
 " " autocmd FileType vimwiki nnoremap <buffer> <silent> - :call Check()<CR>
" augroup END

"- [x] ssdddddddddddddddddds


" augroup MappyTime
  " autocmd!
  " autocmd FileType markdown nnoremap <buffer> <silent> - :call winrestview(<SID>toggle('^\s*-\s*\[\zs.\ze\]', {' ': '.', '.': 'x', 'x': ' '}))<cr>
" augroup END

" function s:toggle(pattern, dict, ...)
  " let view = winsaveview()
  " execute 'keeppatterns s/' . a:pattern . '/\=get(a:dict, submatch(0), a:0 ? a:1 : " ")/e'
  " return view
" endfunction


" config for quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_max_chars=150

" andymass/vim-matchup 
" below line is to disable highlight functionalites
" to lessen possible performance issue
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

" }}}
