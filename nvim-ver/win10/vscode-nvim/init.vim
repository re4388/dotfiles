echom "Load WIN10 NVIM"

" something better put at beginning ========{{{

nnoremap <SPACE> <Nop>
let mapleader=" "

"}}}

" Plugins ============={{{
" Plugins shall put at begin!

call plug#begin(stdpath('config') . '/plugged')

if exists('g:vscode')
	" just not working, no hl...
	" Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
	" map f <Plug>(easymotion-bd-w)
else
	Plug 'vim-airline/vim-airline'
	Plug 'morhetz/gruvbox'
  Plug 'romainl/vim-cool'
	" Plug 'winston0410/commented.nvim'
	Plug 'b3nj5m1n/kommentary'
	" Plug 'easymotion/vim-easymotion'
endif
" map f <Plug>(easymotion-bd-w)

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'

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
Plug 'AndrewRadev/switch.vim'



" good utl
Plug 'tpope/vim-surround' "not consistent for adding (e.g. ysiw')
" Plug 'machakann/vim-sandwich'  " use sa iw '   sd'  sr'
Plug 'tpope/vim-repeat'

Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#s_next = 1

" use Sneak to replace f
" Plug 'unblevable/quick-scope'
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
" let g:qs_max_chars=150

" f for one word and then use f to go to the next one
" s for two word and then use s to go to the next one
" the s behavior is somehow unpredictable in vscode env
" Plug 'ggandor/lightspeed.nvim'
" 
"
" Why I don't like clever-f?
" - only how the hl after the the first hit, no as convenience as
" QuickScope style => may just use QuickScope
" Plug 'rhysd/clever-f.vim'
" g:clever_f_smart_case = 1
" g:clever_f_show_prompt =1 


" Plug 'phaazon/hop.nvim'
" nnoremap f <cmd>lua require'hop'.hint_words()<cr>


Plug 'vim-scripts/ReplaceWithRegister'



" doc
Plug 'romainl/vim-devdocs' " use :DD lang keyword to get doc

call plug#end() "}}}

" vscode helper ============={{{


" function! s:openVSCodeCommandsInVisualMode()
"     normal! gv
"     let visualmode = visualmode()
"     if visualmode == "V"
"         let startLine = line("v")
"         let endLine = line(".")
"         call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
"     else
"         let startPos = getpos("v")
"         let endPos = getpos(".")
"         call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
"     endif
" endfunction


" function! s:vscodeCommentary(...) abort
"     if !a:0
"         let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
"         return 'g@'
"     elseif a:0 > 1
"         let [line1, line2] = [a:1, a:2]
"     else
"         let [line1, line2] = [line("'["), line("']")]
"     endif

"     call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
" endfunction"}}}

if exists('g:vscode')
		
		" vscode only ============={{{
		
		" use vscode to move up and down for jump over folded lines!
		" https://github.com/asvetliakov/vscode-neovim/issues/58
		nnoremap gj :call VSCodeCall('cursorDown')<Cr>
		nnoremap gk :call VSCodeCall('cursorUp')<Cr>
		
		
		" file save and quit
		xnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
		nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
		xnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
		nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
		
	  " back to previous opened file	
		" no need to have this, since we don't to send from vscode to neovim and
		" use vscode binding, we can directly binding over there
		" nnoremap B <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>

		

		" open npm script 
		" comment for now, I use alt+1 and then use `n` to activie npm script
		" xnoremap <leader>r <Cmd>call VSCodeNotify('npm-script.run')<CR>
		" nnoremap <leader>r <Cmd>call VSCodeNotify('npm-script.run')<CR>

    xmap s  <Plug>VSCodeCommentary
    nmap s  <Plug>VSCodeCommentary
    omap s  <Plug>VSCodeCommentary
    nmap ss <Plug>VSCodeCommentaryLine

    " nmap <leader>l <Cmd>call VSCodeNotify('workbench.action.decreaseViewWidth')<CR>
    " nmap <leader>h <Cmd>call VSCodeNotify('workbench.action.increaseViewWidth')<CR>
    " nmap <leader>k <Cmd>call VSCodeNotify('workbench.action.decreaseViewHeight')<CR>
    " nmap <leader>j <Cmd>call VSCodeNotify('workbench.action.increaseViewHeight')<CR>

    " nmap H <Cmd>call VSCodeNotify('workbench.action.decreaseViewWidth')<CR>
    " nmap L <Cmd>call VSCodeNotify('workbench.action.increaseViewWidth')<CR>


    nmap <leader>z <Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>

		" o refer to :so, like run task in vscode
		" change to add space via leader o, I use this way more often
		" and run task and use which key combo or use last command in vsc
		" xnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>
		" nnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>

		" toggle side bar
		" use vsc alt+b
		" xnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
		" nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>


		" quick fix
		nnoremap qf <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
		" I change [[  and ]] to function jump usage in treesitter
		nnoremap <PageDown> <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
		nnoremap <PageUp> <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

		" no need to map to here to call vscode, c-d can directly map it to vscode
		" nnoremap <c-d> <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

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
		" nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

		" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
		" xnoremap <expr> <C-/> <SID>vscodeCommentary()
		" nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

		" xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

		" nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
		" xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

		" use tab to change tab 
		nmap <Tab> gt 
		nmap <S-Tab> gT 

"}}}

else
	  " neovim only ============{{{

		nmap s <Plug>kommentary_motion_default
		xmap s <Plug>kommentary_visual_default
		nmap ss <Plug>kommentary_line_default



		" Return to last edit position when opening files (You want this!)
		au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
		
		if (has("termguicolors"))
 				set termguicolors
		endif
    
		" colorscheme tender
		colorscheme gruvbox
    
		" use leader and w to save
		nnoremap <leader>w :w<cr>
		nnoremap <leader>ww :w<cr>:so %<cr>
		" the counterpart is npm script in vscode
		" nnoremap <leader>r :so %<cr>
		nnoremap <leader>q :q<cr>
		nnoremap <leader>qq :qa<cr>

		nnoremap <c-d> <Nop>

		" go back to previous tab just like vscode
		nnoremap B <c-^>
		

		" Simulate same TAB behavior in VSCode
		nmap <Tab> :tabnext<CR>
		nmap <S-Tab> :tabprev<CR>

		" AUTO FOLD
		" augroup auto_fold_init_vim
			" au!
			" au Filetype vim setlocal foldlevel=0 foldmethod=marker
		" augroup END

		" nno <c-tab> <c-^>


		" after search, center, zz and unfolder zv
		" vscode don't work
		map n nzzzv
		map N Nzzzv

		"""""""""""""""""""""""""""""
		" => ex-mode
		" only works in neovim
		" in vscode, the vscode popup is used
		""""""""""""""""""""""""""""""

		" make ex-mode like emacs terminal mode
		" <C-e>, E: move to end.
		cnoremap <C-e>          <End>
		" <C-a>, A: move to head.

		cnoremap <C-a>          <Home>
		" <C-d>: delete char.
		cnoremap <C-d>          <Del>


		" <C-f>: forward
		cnoremap <C-f>          <Right>
		" <C-b>: backward
		cnoremap <C-b>          <Left>

		" <C-n>: next history.
		cnoremap <C-n>          <Down>
		" <C-p>: previous history.
		cnoremap <C-p>          <Up>


		" Start an external command with a single bang
		nnoremap ! :!


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
		

		"}}}

endif

" Share General Setting ========={{{

set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value, set higher for slow machine, see :h ttimeout
set clipboard=unnamed
"}}}

" Share key mapping ============={{{

" ========================
" fast edit
" ========================


"use enter to fast indent current line
"multiline indent still use V-line mode
nnoremap <cr> >> 

inoremap jk <esc>

" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>


nnoremap ; :
nnoremap : ;
vnoremap : ;
vnoremap ; :

" Better indent in visual mode
vnoremap < <gv
vnoremap > >gv

" want to use `vu` to change to upper case
" so I reverse visual mode u/U mapping
vnoremap u U
vnoremap U u

" also, change to operator,
" `guiw` make the word to upper case
" no need to hit shift
nnoremap gu gU
nnoremap gU gu


" use alt-d to replace .
" also require vscode setting setup to send alt-d to neovim
" nmap <M-x> . 

" when join, do not move cursour
" not working for me since I remap
" noremap J mzJ`z

" Duplicate lines
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv

" Duplicate paragraph and put down
" memonic: cp: copy paragraph
" this is very useful to copy the whole block down and modify it!
" as long as you have padding space between block
nnoremap <Leader>cp yap<S-}>p


" QUIT VISUAL MODE
vnoremap v <Esc>


" inside vscode, we switch b/n two files
nnoremap <c-p> <nop>

" break into next paragraph
nnoremap M i<Cr><Cr><Esc>J


" Do NOT yank with x and d
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" if you want to cut, add c as prefix
nnoremap cd d
nnoremap cD D
vnoremap cd d


" apple   `banana`   "test2'est'
" =========================
" Super Fast Area, Q prefix
" left non-use Q prefix (for macro)
" c, f, 
" ========================

" yank inner word
nnoremap qq yiw 
" replace `m` inner word
nmap cc miw<esc>


"d refer to delete
"to aovid recursive to some unknow reason, I need to use esc to stop
nmap qd daw<esc>

" s => string
" yank inner quote
" need to use namp, since m is remap
nmap qs yiq


" visual line mode
nnoremap vv V


" Add blank line above and below nnoremap
" also take count, like [count]<leader>o
nnoremap qo  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
nnoremap qO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>


" paste on begin(i) and end(a)
" mm and `m is to mark and allow the cursour no move
nnoremap qa mmA<space><esc>p`m
nnoremap qi mmI<c-r>0<space><esc>`m

" Surrounding vim shortcut
" don't forget you can use S in visual mode...
nmap q` ysiw`
nmap q" ysiw"
nmap q' ysiw'
nmap qb ysiwb 
nmap qB ysiwB
nmap qt ysiw<
nmap q[ ysiw[

" m is being used for ReplaceWithRegisterOperator
"need to remap mark `m`
nnoremap qm m
xnoremap qm m

" Use backspace key for matching parens
" n is "n"ext bracket
nnoremap qn %
xnoremap qn %


" move cursor at begin and end of the current line
nnoremap qh g^
nnoremap ql g$
vnoremap qh g^
vnoremap ql g$

" add - at the begin of the current line
nnoremap <leader>p mmI- <esc>`m 

" =================================

" if qh and ql work ok, I can remove below
" nnoremap H g^ 
" nnoremap L gh
" vnoremap H g^
" vnoremap L g$

" combine and break (d => down)
nnoremap <leader>c J
nnoremap <leader>b :<C-u>call BreakHere()<CR>

function! BreakHere()
	s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
	call histdel("/", -1)
endfunction

" cover all non-whitespace conseuctive word

" paste last thing yanked, not deleted
nmap ,p "0p
nmap ,P "0P

" Emacs like movement in Insert/Command
" not sure I am going to use this..?
" noremap! <C-a> <Home>
" noremap! <C-e> <End>
" noremap! <C-f> <Right>
" noremap! <C-b> <Left>
" noremap! <C-d> <Del>

" Disable dengerous/annoying mappings
" ZZ - save and close Vim
" ZQ - close Vim
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" ========================
" easier to move
" ========================


" Treat long lines as break lines (useful when moving around in them)
vmap j gj
vmap k gk

nmap j gj
nmap k gk

" nnoremap j <cmd>call BetterJK('j')<CR>
" nnoremap k <cmd>call BetterJK('k')<CR>


" function! BetterJK(letter)
"   let jump_count = v:count

" "  For wrapped lines, does gj/gk
"   if jump_count == 0
"     call execute(printf('normal! g%s', a:letter))
"     return
"   endif

" "  For large jumps, adds a spot on the jump list
"   if jump_count > 5
"     call execute("normal! m'")
"   endif

"   call execute(printf('normal! %d%s', jump_count, a:letter))
" endfunction




" ========================
" eaier to search
" ========================

" search word under curor with no jump to the next one
nnoremap <silent> <M-m> :keepjumps normal! mi*`i<CR>

" easier to type
nmap <M-n> /
xmap <M-n> /

" To turn off highlighting until the next search
nnoremap <leader>n :noh<cr>

" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" sadly, this can't go well vscode.. QQ
" nnoremap <leader><leader>s :g//#<Left><Left>

"{ddd}
 

" nnoremap J 10gj
" nnoremap K 10gk
" vnoremap J 10gj
" vnoremap K 10gk

" update to qj/qk to align the logic to qh and qk (line end/begin)
" better memonic and also use same q prefix to faster typing a bit?
" shift J/K instead related to other kind of op, shift up and down (also
" good for memonic)
nnoremap qj 20gj
nnoremap qk 20gk
vnoremap qj 20gj
vnoremap qk 20gk


" can NOT use viscode hotkey if I want to 
" move visual select line(s)
" move current line up and down
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv


" use vscode native hotkey
" move current line up and down
" nnoremap qj :m .+1<CR>==
" nnoremap qk :m .-2<CR>==
" vnoremap qj :m '>+1<CR>gv=gv
" vnoremap qk :m '<-2<CR>gv=gv



"}}}


" nvim plugin setting ============={{{

" AndrewRadev/switch.vim
" test
" if(a2 = 3 || a3 = 4)
" flag = true
let g:switch_mapping = "<BS>"

nmap m <Plug>ReplaceWithRegisterOperator




" vim easymotion
" map <Leader><Leader>s <Plug>(easymotion-prefix)
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" let g:EasyMotion_smartcase = 1
" nmap <Leader>s <Plug>(easymotion-s)


" andymass/vim-matchup 
" below line is to disable highlight functionalites
" to lessen possible performance issue
let g:matchup_motion_override_Npercent = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 0
let g:matchup_matchparen_insert_timeout = 0"}}}

" autocommand setting ============={{{

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

"}}}

" useful function ============={{{
"
" Redirect ex-mode output to empty buffer in new tab
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

" example, just fill in namp or namp <leader>
" :call TabMessage("nmap") 
" :call TabMessage("nmap <leader>") 
" then you can use ctrl+o/i to back and forth the new opneing tab
" or you don't need to go back, use 'leader q' to close the tab
nnoremap zh :call TabMessage("nmap")<Left><Left>


"}}}
