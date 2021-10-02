call plug#begin('~/.config/plugged')


" deno
" Plug 'vim-denops/denops.vim'
" set runtimepath^=~/dps-helloworld



"---------------------- nvim-ver unique -------------------------

"----------- COC -------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions
let g:coc_global_extensions = ['coc-eslint', 'coc-snippets', 'coc-tsserver',
      \ 'coc-emmet', 'coc-css', 'coc-html', 'coc-json',
      \'coc-yank', 'coc-prettier', 'coc-marketplace',
      \'coc-sumneko-lua', 'coc-denoland']

Plug 'leafgarland/typescript-vim'

"----------- COC -------------

Plug 'kevinoid/vim-jsonc'
Plug 'junegunn/goyo.vim'
Plug 'yamatsum/nvim-cursorline'
Plug 'mhinz/vim-startify'

"Icon
Plug 'kyazdani42/nvim-web-devicons'

" auto disbale highlight after search
Plug 'romainl/vim-cool' 




"---------------------- nvim-ver unique -------------------------




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
"----------- theme -------------

"visual help
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'Xuyuanp/scrollbar.nvim'
Plug 'dstein64/nvim-scrollview'



"----------- Buffer -------------

" Plug 'romgrk/barbar.nvim'

"----------- Buffer -------------



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

"----------- text objects -------------

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

"----------- Fuzzy Finder -------------


"----------- Explorer -------------
Plug 'kyazdani42/nvim-tree.lua' "
" Plug 'scrooloose/nerdtree'
" Plug 'kevinhwang91/rnvimr'
"----------- Explorer -------------



"----------- Operator -------------

"
Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-commentary'
" Plug 'terrortylor/nvim-comment'
" Plug 'winston0410/commented.nvim'
Plug 'b3nj5m1n/kommentary'
" Plug 'rhysd/accelerated-jk'

"----------- Operator -------------




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
