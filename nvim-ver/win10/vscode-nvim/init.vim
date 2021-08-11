echom "load nvim-for-win and vscode"

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
	Plug 'winston0410/commented.nvim'
	" Plug 'easymotion/vim-easymotion'
endif
" map f <Plug>(easymotion-bd-w)

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
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
let g:sneak#s_next = 1
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_max_chars=150

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
		" change to add space via leader o, I use this way more often
		" and run task and use which key combo or use last command in vsc
		" xnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>
		" nnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.tasks.runTask')<CR>

		" toggle side bar
		" use vsc alt+b
		" xnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
		" nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

		" use leader c is way better then gcc XD
    xmap <leader>c  <Plug>VSCodeCommentary
    nmap <leader>c  <Plug>VSCodeCommentary
    omap <leader>c  <Plug>VSCodeCommentary
    nmap <leader>cc <Plug>VSCodeCommentaryLine

		" quick fix
		nnoremap z= <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
		" I change [[  and ]] to function jump usage in treesitter
		nnoremap <PageDown> <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
		nnoremap <PageUp> <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

		nnoremap <c-d> <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

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
		nnoremap <leader>w :w<cr>:so %<cr>
		" the counterpart is npm script in vscode
		" nnoremap <leader>r :so %<cr>
		nnoremap <leader>q :q<cr>
		nnoremap <leader>qq :qa<cr>

		nnoremap <c-d> <Nop>

		" just like vscode
		nnoremap <M-m> <c-^>
		

		" Simulate same TAB behavior in VSCode
		nmap <Tab> :tabnext<CR>
		nmap <S-Tab> :tabprev<CR>

		" put this into file in auto load place
		augroup auto_fold_init_vim
			au!
			au Filetype vim setlocal foldlevel=0 foldmethod=marker
		augroup END
		
		" Put <enter> to work too! Otherwise <enter> moves to the next line, which we can
		" already do by pressing the <j> key, which is a waste of keys!
		" Be useful <enter> key!:
    " nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
		"
		"
		"

		nno <c-tab> <c-^>


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

inoremap jk <esc>

" align Y to D, C
map Y y$

" Redo
nnoremap U <C-r>



function! BreakHere()
	s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
	call histdel("/", -1)
endfunction

" join and break
nnoremap <leader>j J
nnoremap <leader>b :<C-u>call BreakHere()<CR>


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


" Quit visual mode
vnoremap v <Esc>


" use leade v for faster go to visual line mode
nnoremap <leader>v V


" Duplicate paragraph and put down
" this is very useful to copy the whole block down and modify it!
" as long as you have padding space between block
nnoremap <Leader>cp yap<S-}>p

" vsc don't work
" nnoremap <Leader>l :.,+yank<Left><left><left><left>

" Copy all text in system register
nnoremap ca :%y+<CR>


" paste on space after current cursor 
nnoremap <leader>p a<space><esc>p
" paste on space before current cursor 
nnoremap <c-p> i<c-r>0<space><esc>


" Do NOT yank with x/s 	
nnoremap x "_x

" super fast whole word/WORD selection.. 
nno ee yiw 
" nno ww yaW
nmap ww yiq
nmap cc miw
" nno e. yiW 
" nno w, yaw 



" cover all non-whitespace conseuctive word

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


" I think maybe combo is faster
nnoremap H g^ 
nnoremap L g$
vnoremap H g^
vnoremap L g$




" ========================
" eaier to search
" ========================


" currently, vscode sometimes don't update the cursor
" so I need to use vscode native search
" here in neovim, also use alt+m to active the word under cursor search
" find word in file under cursor
"
" Will remove below when I get used to use enter to cursor-search
" nmap <M-m> *
" vmap <M-m> *

" Put <enter> to work ! Otherwise <enter> moves to the next line, which we can
" already do by pressing the <j> key, which is a waste of keys!
" Be useful <enter> key!:
nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

" easier to type
nmap <M-n> /
xmap <M-n> /

" To turn off highlighting until the next search
nnoremap <leader>n :noh<cr>

" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" sadly, this can't go well vscode.. QQ
" nnoremap <leader><leader>s :g//#<Left><Left>

"{ddd}
 

" Use backspace key for matching parens
nnoremap <M-q> %
xnoremap <M-q> %

nnoremap <c-u> %
xnoremap <c-u> %



" use mj mk, just don't use j and k as mark key
nnoremap mj :m .+1<CR>==
nnoremap mk :m .-2<CR>==
vnoremap mj :m '>+1<CR>gv=gv
vnoremap mk :m '<-2<CR>gv=gv


nnoremap J 10j
nnoremap K 10k
vnoremap J 10j
vnoremap K 10k


" had use J above, so I here remap join to ctrl+c prefix version
" nnoremap <C-c>j J
" noremap gj J

" also take count, like [count]<leader>o
" add blank line above and below
nnoremap <leader>o  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
nnoremap <leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>





"}}}


" nvim plugin setting ============={{{

" AndrewRadev/switch.vim
" test
" if(a2 = 3 || a3 = 4)
" flag = true
let g:switch_mapping = "<BS>"

nmap m <Plug>ReplaceWithRegisterOperator
"need to remap mark `m`
nnoremap <leader>m m
xnoremap <leader>m m


" ref:
" https://github.com/nvim-treesitter/nvim-treesitter#language-parsers
" https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/javascript/textobjects.scm

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

       -- no idea which key to refer class, also, I seldom need to choose the whole class
			 -- the current working project like to use class as a file
       --  ["ao"] = "@class.outer",
       --  ["io"] = "@class.inner",

       -- o for loop
        ["ao"] = "@loop.outer",
        ["io"] = "@loop.inner",
       -- c for condition
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
       -- i for invocation
        ["ii"] = "@call.inner",
        ["ai"] = "@call.outer",

				-- block seems mix with function and try-catch, but not statement block
        -- ["ik"] = "@block.inner",
        -- ["ak"] = "@block.outer",

				-- use ib is more accurate
        -- ["ip"] = "@parameter.inner",
        -- para outter no support
        -- Or you can define your own textobjects like this
      },
    },
		move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]]"] = "@function.outer",
					["))"] = "@call.outer",
					["}}"] = "@loop.outer",
					[">>"] = "@conditional.outer",
				},
				goto_previous_start = {
					["[["] = "@function.outer",
					["(("] = "@call.outer",
					["{{"] = "@loop.outer",
					["<<"] = "@conditional.outer",
				},
		},
  },
}
EOF

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
" handy stuff to check ex-mode output
" this will redirect ex-mode output to empty buffer in new tab
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
nnoremap <leader>hh :call TabMessage("nmap")<Left><Left>


"}}}
