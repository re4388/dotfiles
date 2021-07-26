
echo "load nvim-for-win and vscode"


nnoremap <SPACE> <Nop>
let mapleader=" "

" nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
" nmap s <Plug>ReplaceWithRegisterOperator

call plug#begin(stdpath('config') . '/plugged')

Plug 'vim-airline/vim-airline'
" Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
" gc
" already built in in vscode-neovim
" Plug 'tpope/vim-commentary'
" Plug 'terrortylor/nvim-comment'

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




let g:sneak#s_next = 1

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
endfunction



if exists('g:vscode')
		
	  " =======================================
		" leader key in VScode
		" =======================================
		
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

		" set clipboard=unnamed
else
		if (has("termguicolors"))
 				set termguicolors
		endif
    
		" use another leader + c for non-vscode comment
    lua require('commented').setup()

	  " =======================================
		" leader key in window (not vscode)
		" =======================================
		
		" use leader and w to save
		nnoremap <leader>w :w<cr>
		" the counterpart is npm script in vscode
		nnoremap <leader>r :so %<cr>
		nnoremap <leader>q :q<cr>
		
		" Start an external command with a single bang
		nnoremap ! :!
		" Simulate same TAB behavior in VSCode
		nmap <Tab> :tabnext<CR>
		nmap <S-Tab> :tabprev<CR>

		" Better tabbing in visual mode
		vnoremap < <gv
		vnoremap > >gv

		" Theme
		" syntax enable

		" colorscheme tender
		colorscheme gruvbox

    set relativenumber
    set ruler
    set syntax
    " syntax on
    set wrap
    set noswapfile
		set shiftwidth=2
		set autoindent
		set smartindent
		set tabstop=2

endif

" faster ex mode
nnoremap <CR> :

" =======================================
" Below are shared by win & vscode
" =======================================
		
set clipboard=unnamed

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

" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" sadly, this can't go well vscode.. QQ
" nnoremap <leader><leader>s :g//#<Left><Left>

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



