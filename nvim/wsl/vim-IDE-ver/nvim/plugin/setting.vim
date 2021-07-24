
" persistent undo
set undofile " Maintain undo history between sessions

"nvim_treesitter setting
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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
set foldenable
set foldlevel=5
set hidden            " Required to keep multiple buffers open multiple buffers
set hlsearch            " highlight searches2
set ignorecase          " ignore case when searching
set incsearch           " do incremental searching
set iskeyword+=-      " treat dash separated words as a word text object"
set mouse=a           " Enable your mouse
set noeb                     " close bee sound when error
set noshowmode         " We don't need to see things like -- INSERT -- anymore
set nowrap            " Display long lines as just one line
set nowritebackup      " This is recommended by coc
" set number              " show line numbers
set pumheight=10      " Makes popup menu smaller
" set relativenumber
set scrolloff=3         " keep 3 lines when scrolling
set showcmd             " display incomplete commands
set showmatch           " jump to matches when entering regexp
set showtabline=2      " Always show tabs
set smartcase           " no ignorecase if Uppercase char present
set smartindent
set splitbelow        " Horizontal splits will automatically be below
set splitright        " Vertical splits will automatically be to the right
set timeoutlen=500     " By default timeoutlen is 1000 ms
set updatetime=300     " Faster completion

" not sure below config work, follow vim-better-default"
set foldenable
set foldmarker={,}
set foldlevel=0
set foldlevelstart=99


set number
set relativenumber

" Turn on the Wild menu
set wildmenu


"Always show current position
set ruler

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

""""""""""""""""""""""""""""""""
" => Colors and Fonts
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
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

set shiftwidth=2
set tabstop=2

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
