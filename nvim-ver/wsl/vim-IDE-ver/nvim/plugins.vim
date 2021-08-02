
call plug#begin('~/.config/plugged')




" deno
Plug 'vim-denops/denops.vim'
set runtimepath^=~/dps-helloworld

" TypeScript
"------------------------ COC ------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions
let g:coc_global_extensions = ['coc-eslint', 'coc-snippets', 'coc-tsserver',
      \ 'coc-emmet', 'coc-css', 'coc-html', 'coc-json',
      \'coc-yank', 'coc-prettier','coc-marketplace',
      \'coc-sumneko-lua', 'coc-denoland']

Plug 'leafgarland/typescript-vim'
Plug 'kevinoid/vim-jsonc'
Plug 'yamatsum/nvim-cursorline'





Plug 'mhinz/vim-startify'

" fooBar, qq_bar, SeriesPreprocessBar
Plug 'Julian/vim-textobj-variable-segment'
" iv and av
Plug 'nelstrom/vim-visual-star-search' " enable *(M-m in my keymap) in visual mode


" like favoriats file
" replace with oldfiles with finder plugin
" Plug 'ThePrimeagen/harpoon'

" status line
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'

"visual help
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'Xuyuanp/scrollbar.nvim'

"Icon
Plug 'kyazdani42/nvim-web-devicons'

"Buffer management"
" Plug 'romgrk/barbar.nvim'

Plug 'kana/vim-textobj-entire'
" e
" create your own text objects
Plug 'kana/vim-textobj-user'
" f in c, java and vim
Plug 'kana/vim-textobj-function'
" extended version of above
Plug 'haya14busa/vim-textobj-function-syntax'
" l 
Plug 'kana/vim-textobj-line'
" i
Plug 'michaeljsmith/vim-indent-object'
" %
Plug 'andymass/vim-matchup'
" q
Plug 'wellle/targets.vim'
" I like this plugin, maybe oneday I will enable it when I do coding!
" Plug 'mbbill/undotree'



" doc in vim
" try :DD js map
Plug 'romainl/vim-devdocs'

" fuzzy finder
" Plug 'rking/ag.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" try to use this, seems faster
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }




"Explorer
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'scrooloose/nerdtree'
" Plug 'kevinhwang91/rnvimr'

"Operator
Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-commentary'
" Plug 'terrortylor/nvim-comment'
Plug 'winston0410/commented.nvim'
" Plug 'rhysd/accelerated-jk'


"Game"
" Plug 'ThePrimeagen/vim-be-good'

"Motion"
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1

"project management
" Rooter changes the working directory to the project root  
" Plug 'airblade/vim-rooter'

" enable when I need
" Plug 'vim-test/vim-test'

" auto disbale highlight after search
Plug 'romainl/vim-cool'

" auto session
" Plug 'rmagatti/auto-session'

" not working 2021_07_21_08_10
" Plug 'tpope/vim-obsession'



Plug 'vimwiki/vimwiki'

Plug '907th/vim-auto-save'

" Autocompletion related
" Plug 'hrsh7th/nvim-compe'
Plug 'cohama/lexima.vim'

" Plug 'nvim-lua/completion-nvim'
" Plug 'windwp/nvim-autopairs'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

"Lsp
Plug 'neovim/nvim-lspconfig'

Plug 'kabouzeid/nvim-lspinstall'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'folke/lua-dev.nvim'
" Plug 'onsails/lspkind-nvim'
" not working...don't know why... 
" Plug 'RishabhRD/popfix'
" Plug 'RishabhRD/nvim-lsputils'

" Plug 'dense-analysis/ale'

"Quickfix related
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Plug 'Raimondi/delimitMate'
" use <c-j> to corss delimiter and bracket
" Plug 'dhruvasagar/vim-pairify'


" Snippet
" Plug 'hrsh7th/vim-vsnip'
" Plug 'rafamadriz/friendly-snippets'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'



"Formatter
" Plug 'mhartington/formatter.nvim'
" Floting terminal 
" Plug 'numtostr/FTerm.nvim'

" show key
" Plug 'liuchengxu/vim-which-key'

"Folder management"
" Any file in ftplugin/*.lua or after/ftplugin/*.lua will now get automatically run at the correct time after installing this plugin.
" To automatically run a file on startup with lua, put the file in lua/plugin/*.lua and the file will be executed at statup.
" see ftplugin/vim.lua for demo
Plug 'tjdevries/astronauta.nvim'

" Plug 'abecodes/tabout.nvim'


call plug#end()
