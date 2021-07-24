
call plug#begin('~/.config/plugged')

" Theme
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
" Plug 'jacoborus/tender.vim'
" Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline-themes'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'Xuyuanp/scrollbar.nvim'

"Icon
Plug 'kyazdani42/nvim-web-devicons'

"Buffer management"
" Plug 'romgrk/barbar.nvim'

"Text objects"
" e
Plug 'kana/vim-textobj-entire'
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

"Explorer
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'scrooloose/nerdtree'
" Plug 'kevinhwang91/rnvimr'

"Operator
Plug 'vim-scripts/ReplaceWithRegister'
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

"project management
" Rooter changes the working directory to the project root  
Plug 'airblade/vim-rooter'


Plug 'vim-test/vim-test'


" auto disbale highlight after search
Plug 'romainl/vim-cool'

" auto session
Plug 'rmagatti/auto-session'

" not working 2021_07_21_08_10
" Plug 'tpope/vim-obsession'



Plug 'vimwiki/vimwiki'

Plug '907th/vim-auto-save'

" Autocompletion related
Plug 'hrsh7th/nvim-compe'
Plug 'cohama/lexima.vim'

" Plug 'nvim-lua/completion-nvim'
" Plug 'windwp/nvim-autopairs'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  

"Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'onsails/lspkind-nvim'
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
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'



"Formatter
Plug 'mhartington/formatter.nvim'
" Floting terminal 
" Plug 'numtostr/FTerm.nvim'

" show key
" Plug 'liuchengxu/vim-which-key'

"Folder management"
" Any file in ftplugin/*.lua or after/ftplugin/*.lua will now get automatically run at the correct time after installing this plugin.
" To automatically run a file on startup with lua, put the file in lua/plugin/*.lua and the file will be executed at statup.
" see ftplugin/vim.lua for demo
Plug 'tjdevries/astronauta.nvim'

call plug#end()
