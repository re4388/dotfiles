"######################################################
"#
"# prelogue
"#
"######################################################
echom "load wsl-v1-init.vim"

let g:mapleader = "\<Space>"



"######################################################
"#
"#    plugin 
"#
"######################################################

call plug#begin('~/.config/plugged')

" deno
" Plug 'vim-denops/denops.vim'
" set runtimepath^=~/dps-helloworld



"----------------------------------------------------------
"----------- COC ------------------------------------------
"----------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions
let g:coc_global_extensions = ['coc-eslint', 'coc-snippets', 'coc-tsserver',
      \ 'coc-emmet', 'coc-css', 'coc-html', 'coc-json',
      \'coc-yank', 'coc-prettier', 'coc-marketplace', 'coc-jedi',
      \'coc-sumneko-lua', 'coc-denoland']

Plug 'leafgarland/typescript-vim'

"----------------------------------------------------------
"----------- COC ------------------------------------------
"----------------------------------------------------------

Plug 'kevinoid/vim-jsonc'
Plug 'junegunn/goyo.vim'
Plug 'yamatsum/nvim-cursorline'
Plug 'mhinz/vim-startify'

"Icon
Plug 'kyazdani42/nvim-web-devicons'

" auto disbale highlight after search
Plug 'romainl/vim-cool' 

Plug 'nelstrom/vim-visual-star-search' " enable *(M-m in my keymap) in visual mode

" like favoriats file
" replace with oldfiles with finder plugin
" Plug 'ThePrimeagen/harpoon'

" status line
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

"----------- theme -------------
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'



"visual help
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'Xuyuanp/scrollbar.nvim'
Plug 'dstein64/nvim-scrollview'



"----------- Buffer -------------

" Plug 'romgrk/barbar.nvim'




"----------- text objects -------------

" fooBar, qq_bar, SeriesPreprocessBar
" " iv and av
Plug 'Julian/vim-textobj-variable-segment'
Plug 'kana/vim-textobj-entire'
" e
Plug 'kana/vim-textobj-user' " create your own text objects
Plug 'kana/vim-textobj-function' " f in c, java and vim
Plug 'haya14busa/vim-textobj-function-syntax' " extended version of above
Plug 'kana/vim-textobj-line' " l 
" Plug 'michaeljsmith/vim-indent-object' " i
Plug 'andymass/vim-matchup' " %
Plug 'wellle/targets.vim' " q
" I like this plugin, maybe oneday I will enable it when I do coding!
" Plug 'mbbill/undotree'
Plug 'romainl/vim-devdocs' " try :DD js map




"----------- Fuzzy Finder -------------
 
" Plug 'rking/ag.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" try to use this, seems faster
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }



"----------- Explorer -------------
Plug 'kyazdani42/nvim-tree.lua' "
" Plug 'scrooloose/nerdtree'
" Plug 'kevinhwang91/rnvimr'



"----------- Operator -------------

Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-commentary'
" Plug 'terrortylor/nvim-comment'
" Plug 'winston0410/commented.nvim'
Plug 'b3nj5m1n/kommentary'
" Plug 'rhysd/accelerated-jk'





"----------- Game -------------

" Plug 'ThePrimeagen/vim-be-good'

"----------- Game -------------



"----------- Motion-------------
""
Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#s_next = 1
" Plug 'unblevable/quick-scope'
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" let g:qs_max_chars=150
" highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

" f for one word and then use f to go to the next one
" s for two word and then use s to go to the next one
" Plug 'ggandor/lightspeed.nvim'

"----------- Motion-------------



"----------- project management -------

" Rooter changes the working directory to the project root  
" Plug 'airblade/vim-rooter'
" auto session
" Plug 'rmagatti/auto-session'

" not working 2021_07_21_08_10
" Plug 'tpope/vim-obsession'

" Any file in ftplugin/*.lua or after/ftplugin/*.lua will now get automatically run at the correct time after installing this plugin.
" To automatically run a file on startup with lua, put the file in lua/plugin/*.lua and the file will be executed at statup.
" see ftplugin/vim.lua for demo
Plug 'tjdevries/astronauta.nvim'

"----------- project management -------



"----------- test utils -------
" enable when I need
" Plug 'vim-test/vim-test'

"----------- test utils -------


Plug 'vimwiki/vimwiki'
Plug 'AndrewRadev/switch.vim'

Plug '907th/vim-auto-save'

" Autocompletion related
" Plug 'hrsh7th/nvim-compe'
Plug 'cohama/lexima.vim'

" Plug 'nvim-lua/completion-nvim'
" Plug 'windwp/nvim-autopairs'

"----------- Treesitter -------

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'

"----------- Treesitter -------

"----------- Lsp -----------------
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'folke/lua-dev.nvim'
" Plug 'onsails/lspkind-nvim'
" not working...don't know why... 
" Plug 'RishabhRD/popfix'
" Plug 'RishabhRD/nvim-lsputils'
"----------- Lsp -----------------


" forget what it is..
" Plug 'dense-analysis/ale'

"----------- Quickfix -----------------
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Plug 'Raimondi/delimitMate'
" use <c-j> to corss delimiter and bracket
" Plug 'dhruvasagar/vim-pairify'
"----------- Formatter -----------------



"----------- Snippet -----------------
" 
" Plug 'hrsh7th/vim-vsnip'
" Plug 'rafamadriz/friendly-snippets'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

"----------- Snippet -----------------



"----------- Formatter -----------------
"
" Plug 'mhartington/formatter.nvim'
" Floting terminal 
" Plug 'numtostr/FTerm.nvim'

"----------- Formatter -----------------



" show key
" Plug 'liuchengxu/vim-which-key'


" Plug 'abecodes/tabout.nvim'


call plug#end()


"######################################################
"#
"#    setting
"#
"######################################################


" persistent undo
set undofile " Maintain undo history between sessions


" FOLDING
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable            " no folding by default
" set foldmethod=marker       " fold based on ...
" set foldnestmax=10         " deepest fold is 10 levels
" set foldlevel=1             " fold one level at a time
" ref: https://vim.fandom.com/wiki/Folding#Folding_methods

" set t_Co=256          " Support 256 colors
set clipboard=unnamed
set autochdir
set autoindent
" set background=dark    " tell vim what the background color looks like
set cmdheight=1       " More space for displaying messages
set conceallevel=0    " So that I can see `` in markdown files
set cursorline         " Enable highlighting of the current line
" set fileencoding=utf-8 " The encoding written to file
set foldcolumn=1
" set foldenable
set foldlevel=5
set hidden            " Required to keep multiple buffers open multiple buffers
set hlsearch            " " highlight matches
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present
set incsearch           " do incremental searching
set iskeyword+=-      " treat dash separated words as a word text object"
set mouse=a           " Enable your mouse
set noeb                     " close bee sound when error
set noshowmode         " We don't need to see things like -- INSERT -- anymore
set nowrap            " Display long lines as just one line
set nowritebackup      " This is recommended by coc
" set number              " show line numbers
set pumheight=10      " Makes popup menu smaller
set scrolloff=5         " " start scrolling viewport 5 lines ahead of cursor
set showcmd             " display incomplete commands
set showmatch           " highlight matching [{()}]
set showtabline=2      " Always show tabs
set smartindent
set splitbelow        " Horizontal splits will automatically be below
set splitright        " Vertical splits will automatically be to the right
set timeoutlen=500     " By default timeoutlen is 1000 ms
set ttimeout          " for key codes
set ttimeoutlen=10    " small value for quick control sequence sending, set higher for slow machine, see :h ttimeout
set updatetime=300     " Faster completion

" not sure below config work, follow vim-better-default"
set foldenable
set foldmarker={,}
set foldlevel=0
set foldlevelstart=99
set number
set relativenumber
" Turn on the Wild menu
set wildmenu " turn on tab completion menu
"TODO: what is this?
" set wildmode=list:longest   " make tab completion work like shell
"Always show current position
set ruler
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set whichwrap+=<,>,h,l



""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

" Enable syntax highlighting
" syntax enable 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
"""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""
set expandtab "insert spaces when tab key is pressed


" INDENT
set smarttab " Be smart when using tabs
set shiftwidth=2 " 1 indentation == 2 spaces
set tabstop=2  " 1 tab == 2 spaces
set backspace=eol,start,indent " Configure backspace so it acts as it should act
" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


set nocompatible
" this enable your after/ ...etc folder to be picked up when start up
filetype plugin on
syntax on

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c



"######################################################
"#
"#    hotkey
"#
"######################################################



""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" File mgmt
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

" (r)eload config
" nnoremap <leader>r :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
" nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>ww :w<CR>:source ~/.config/nvim/init.vim<CR>
nnoremap <leader>w :w<CR>

  nnoremap <silent> <leader>q :bd<CR> 
nnoremap <silent> <Leader>qq  :qa!<CR>

" nnoremap <M-u> :Format<CR>

" for vimscript and lua, this is run up the file
" TODO: change to other later...
" nnoremap <leader>o :so %<CR>




""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" Search 
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

" easier to type
xmap <M-n> /
nmap <M-n> /

" clear hightligh
nnoremap <leader>n :noh<cr>



" note: enter to use my pinkey finger to touch..too far
" we don't want to jump to next when I use *, below script will be a 'no move under cursor search'
" below only work for <cr> as trigger key
" nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

nnoremap <silent> <m-m> :keepjumps normal! mi*`i<CR>


" after search, center, zz and unfolder zv
map n nzzzv
map N Nzzzv




""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" Move
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""





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
""""""""""""""""""""""""""""""
" Edit
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
nnoremap <cr> >> 
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

" test
" if(a2 = 3 || a3 = 4)
" flag = true
let g:switch_mapping = "<BS>"


nmap m <Plug>ReplaceWithRegisterOperator

" break into next paragraph
nnoremap M i<Cr><Cr><Esc>J

" Duplicate paragraph and put down
nnoremap <Leader>cp yap<S-}>p

" Duplicate lines and put down
" make it even easier than yyp
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv



" =========================
" =========================
" Fast eid
" =========================
" use q ===================
" =========================
" q is the default macro prefix..
" if I want to use macro..
" I can still have many to use, like c, f 
" ========================
" ========================


nnoremap qq yiw 
nmap cc miw<esc>

"to aovid recursive to some unknow reason, I need to use esc to stop
nmap qd daw<esc>
" s => string
nmap qs yiq
" need to use namp, since m is remap

" visual line mode
" nnoremap qv V
nnoremap vv V

" Add blank line above and below
" also take count, like [count]<leader>o
nnoremap qo  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
nnoremap qO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>


" paste on begin and end
" mm and `m is to mark and allow the cursour no move
nnoremap qa mmA<space><esc>p`m
nnoremap qi mmI<c-r>0<space><esc>`m

" eaiser surrounding vim
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
" =================================
" nnoremap <leader>l mmI- <esc>`m 

" move current line up and down
nnoremap qj 20gj
nnoremap qk 20gk
vnoremap qj 20gj
vnoremap qk 20gk

nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv
" move current line up and down
" nnoremap qj :m .+1<CR>==
" nnoremap qk :m .-2<CR>==
" vnoremap qj :m '>+1<CR>gv=gv
" vnoremap qk :m '<-2<CR>gv=gv

" try qh and ql
nnoremap qh g^ 
nnoremap ql g$
vnoremap qh g^
vnoremap ql g$
" =================================

" if qh and ql work ok, I can remove below
" nnoremap H g^ 
" nnoremap L g$
" vnoremap H g^
" vnoremap L g$



" use a as make in one "L""ne
" join and break (d => down)
" I use shift J to shift stuff
nnoremap <leader>a J
nnoremap <leader>b :<C-u>call BreakHere()<CR>


" nnoremap gt gg 
" cover all non-whitespace conseuctive word

" Quit visual mode
vnoremap v <Esc>
" tab out
" https://www.reddit.com/r/vim/comments/6ga90i/tabbing_out_of_brackets_and_quotes/
" inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'   
inoremap <expr> <Tab> getline('.')[col('.')-1] =~? '[]>)}''"`]' ? '<Right>' : '<Tab>'   


" had use J above, so I here remap join to ctrl+c prefix version
" nnoremap gj J

" reamp K to leader K, S-K can open man under cursor
" noremap <leader>k :execute "tab h " . expand("<cword>")<cr>


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
vnoremap : ;
vnoremap ; :


 " Insert empty line above, repeatable
 " noremap <silent> <Plug>EmptyLineAbove mmO<ESC>`m:call repeat#set("\<Plug>EmptyLineAbove")<CR>
 " nmap <leader>O <Plug>EmptyLineAbove
 "
 "Insert empty line below, repeatable
 " nnoremap <silent> <Plug>EmptyLineBelow mmo<ESC>`m:call repeat#set("\<Plug>EmptyLineBelow")<CR>
 " nmap <leader>o <Plug>EmptyLineBelow

" Copy whole text in system register
" copy all!
nnoremap ca :%y+<CR>

" clear down
" nnoremap cd mmA<cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><cr><esc>`m

" paste last thing yanked, not deleted
nmap ,p "0p
nmap ,P "0P


" Do NOT yank with x and d
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" if you want to cut, add c
nnoremap cd d
nnoremap cD D
vnoremap cd d


" Disable dengerous/annoying mappings
" ZZ - save and close Vim
" ZQ - close Vim
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>



""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
"  remove all arrow key
""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""
" Tab mgmt 
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

" just like vscode
nnoremap B  <c-^>

" nnoremap <C-tab> <c-^>

nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>



""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" Terminal Mode
""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""
" windown mgmt 
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

" easier to change panel
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k

"resize
" nnoremap <C-Left> :vertical resize +2<cr>
" nnoremap <C-Right> :vertical resize -2<cr>
" nnoremap <C-Up> :resize -2<cr>
" nnoremap <C-Down> :resize +2<cr>

"resize
nnoremap <S-l> :vertical resize +2<cr>
nnoremap <S-h> :vertical resize -2<cr>
nnoremap <S-k> :resize -2<cr>
nnoremap <S-j> :resize +2<cr>







"""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""
" => ex-mode 
""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""


" Quick command mod
" nnoremap <CR> :

" Run the last command
nnoremap <m-1> :<up><esc>



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




""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" Some advance shorcut
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""

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
" nnoremap <leader><leader>h :call TabMessage("nmap")<Left><Left>
nnoremap <leader>hh :call TabMessage("nmap")<Left><Left>


""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Misc 
""""""""""""""""""""""""""""""
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


" Plugin need to put first
" source ~/.config/nvim/plugins.vim
" source ~/.config/nvim/setting.vim
" source ~/.config/nvim/keymap.vim


" lua require('commented').setup()
" lua require("lsp-config")
colorscheme one

"================================
"============= abbr =============
"================================


:ab rtfm read the the fine manual

"================================
"=============  functional key try out =============
"================================


" use <C-K> and type f2...to f7 to try out
" f2: <F26>
" f3 :<F27>
" f4 :<F28>
" f5: <F29>
" f6: <F30>
" f7: <F31>

" nmap <f26> yiw 
" nmap <c-f4> yiw 
" nmap <c-f5> yiw 
" nmap <c-f6> yiw 


"================================
"============= b3nj5m1n/kommentary =============
"================================


nmap s <Plug>kommentary_motion_default
xmap s <Plug>kommentary_visual_default
nmap ss <Plug>kommentary_line_default


"================================
"============= vim-matchup =============
"================================

let g:matchup_motion_override_Npercent = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 0
let g:matchup_matchparen_insert_timeout = 0


"================================
"============= autosave plugin ==
"================================

" dsiable autosave gloablly
let g:auto_save = 0
" only autosave for md file
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType vimwiki let b:auto_save = 1
augroup END


"================================
"============= treesitter =======
"================================
" removed, no use now


"================================
"============= autocommand ======
"================================
" set folding stgy for vim file
"
" augroup auto_fold_init_vim
" 	au!
" 	au Filetype vim setlocal foldlevel=0 foldmethod=marker
" augroup END


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END


" autocmd FileType typescript let b:match_words = '\<if\>::\<else\>'
" let b:match_words = '\<if\>:\<endif\>,'
" \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'}}}

"================================
"============= POC =============
"================================

" let b:match_ignorecase=0
"     let b:match_words =
"      \  '<:>,' .
"      \  '<\@<=!--:-->,'.
"      \  '<\@<=?\k\+:?>,'.
"      \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
"      \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'.
"      \  '\<if\>::\<else\>'
