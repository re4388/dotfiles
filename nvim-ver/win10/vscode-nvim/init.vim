echom "load nvim-for-win and vscode"

" something better put at beginning ========{{{

nnoremap <SPACE> <Nop>
let mapleader=" "

"}}}

" Plugins ============={{{
" Plugins shall put at begin!

call plug#begin(stdpath('config') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'



" if exists('g:vscode')
	" Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
" else
	" Plug 'easymotion/vim-easymotion'
" endif


" use vscode easymotion when in vscode mode

" text object
Plug 'Julian/vim-textobj-variable-segment' " iv and av for fooBar, qq_bar, SeriesPreprocessBar
Plug 'nelstrom/vim-visual-star-search' " enable *(M-m in my keymap) in visual mode, good to select more than one word
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim' " let you use ciq and use cib for both [ and { 

" better %/<BS> function
" like jump to close bracket even in the same line
" but still there's some functionality not working in TS file
Plug 'andymass/vim-matchup'

Plug 'winston0410/commented.nvim'


" good utl
" Plug 'tpope/vim-surround' "not consistent for adding (e.g. ysiw')
Plug 'machakann/vim-sandwich'  " use sa iw '   sd'  sr'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'romainl/vim-cool'

" movement
Plug 'unblevable/quick-scope'

" doc
Plug 'romainl/vim-devdocs' " use :DD lang keyword to get doc

call plug#end() "}}}

" vscode helper ============={{{

function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

function! s:vscodeCommentary(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
endfunction"}}}

if exists('g:vscode')
		
		" vscode only ============={{{
		
		" file save and quit
		xnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
		nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
		xnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
		nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

		" open npm script
		xnoremap <leader>r <Cmd>call VSCodeNotify('npm-script.run')<CR>
		nnoremap <leader>r <Cmd>call VSCodeNotify('npm-script.run')<CR>

		" o refer to :so, like run task in vscode
		xnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>
		nnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>

		" toggle side bar
		xnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
		nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

		" use leader c is way better then gcc XD
    xmap <leader>c  <Plug>VSCodeCommentary
    nmap <leader>c  <Plug>VSCodeCommentary
    omap <leader>c  <Plug>VSCodeCommentary
    nmap <leader>cc <Plug>VSCodeCommentaryLine

		" quick fix
		nnoremap z= <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>

		" window navigation, overwrite the default vscode-neovim binding
		nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
		xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
		nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
		xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
		nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
		xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
		nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
		xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

		"toggle folding
		nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>

		"remap to gr for comment ppl use, gH is the vscode neovim binding
		nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

		" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
		xnoremap <expr> <C-/> <SID>vscodeCommentary()
		nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

		xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

		" use space as which key, but this way is slow.. 
		" nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
		" xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

		" use tab to change tab 
		nmap <Tab> gt 
		nmap <S-Tab> gT 

"}}}

else

	  " neovim only ============{{{
		
		if (has("termguicolors"))
 				set termguicolors
		endif
    
		" colorscheme tender
		colorscheme gruvbox
    
		" comment plugin only for neovim
    lua require('commented').setup()

		" use leader and w to save
		nnoremap <leader>w :w<cr>
		" the counterpart is npm script in vscode
		nnoremap <leader>r :so %<cr>
		nnoremap <leader>q :q<cr>
		nnoremap <leader>qq :qa<cr>
		
		" Start an external command with a single bang
		nnoremap ! :!

		" Simulate same TAB behavior in VSCode
		nmap <Tab> :tabnext<CR>
		nmap <S-Tab> :tabprev<CR>

		" Better indent in visual mode
		vnoremap < <gv
		vnoremap > >gv

		" Theme
		" syntax enable


    set relativenumber
    set ruler
    set syntax
    " syntax on
    set wrap
    set noswapfile
		set shiftwidth=2
		set autoindent
		set smartindent
		set tabstop=2"}}}

endif

" Share General Setting ========={{{

set clipboard=unnamed
"}}}

" Share key mapping ============={{{


" faster ex mode
nnoremap <CR> :

" ========================
" fast edit
" ========================

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
nmap <M-d> . 



" Duplicate lines
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv


" Quit visual mode
vnoremap v <Esc>


" use leade v for faster go to visual line mode
nnoremap <leader>v V


" Duplicate paragraph and put down
" this is very useful to copy the whole block down and modify it!
" as long as you have padding space between block
nnoremap <Leader>cp yap<S-}>p



" ========================
" easier to move
" ========================

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk



" try use <leader> as prefix
nnoremap <leader>h g^
nnoremap <leader>l g$
vnoremap <leader>h g^
vnoremap <leader>l g$



" ========================
" eaier to search
" ========================

" easier to type
xmap <M-n> /
nmap <M-n> /


" To turn off highlighting until the next search
nnoremap <leader>n :noh<cr>

" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" sadly, this can't go well vscode.. QQ
" nnoremap <leader><leader>s :g//#<Left><Left>

" find word in file under cursor
nmap <M-m> *
vmap <M-m> *

nmap m <Plug>ReplaceWithRegisterOperator
"remap mark `m` to gm
nnoremap gm m
xnoremap gm m
 

" Use backspace key for matching parens
nnoremap <M-q> %
xnoremap <M-q> %


" use shift j/k to move line down/up
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" had use J above, so I here remap join to ctrl+c prefix version
nnoremap <C-c>j J"}}}

" nvim plugin setting ============={{{
"
" vim sneak
let g:sneak#s_next = 1

" vim easymotion
" map <Leader><Leader>s <Plug>(easymotion-prefix)
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" let g:EasyMotion_smartcase = 1
" nmap <Leader>s <Plug>(easymotion-s)

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
let g:matchup_matchparen_insert_timeout = 0"}}}

" autocommand setting ============={{{
" put this into file in auto load place
augroup auto_fold_init_vim
	au!
	au Filetype vim setlocal foldlevel=0 foldmethod=marker
augroup END"}}}

