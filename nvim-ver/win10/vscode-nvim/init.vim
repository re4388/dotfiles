let mapleader = " "

"============================================================================
" General settings
"============================================================================
"
"
set clipboard+=unnamedplus
set nocompatible        " Turn off vi compatibility
set undolevels=1000     " Lots and lots of undo
set history=50          " Size of :command history
set showcmd             " Display incomplete commands
set showmatch           " Show matches on parens, bracketc, etc.


set smartindent         " smart indent
set nobackup            " do not keep a backup file, use versions instead
set ruler               " show the cursor position all the time
set number              " show the line number

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


" Enable folding by fold markers
set foldmethod=marker

" Autoclose folds, when moving out of them
"set foldclose=all


"============================================================================
" Colorscheme
"============================================================================
filetype on
syntax on
colorscheme default      " blue, darkblue, default, delek, desert, elflord
                        " evening, koehler, morning, murphy, pablo,
                        " peachpuff, ron, shine, slate, torte, zellner
set background=light    " dark or light



"============================================================================
" Tab standards.
"============================================================================
"Sorry, 8 spaces are too much for nested loops!
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround          " indent/outdent to nearest tabstops
set expandtab           " enter spaces when tab is pressed


"============================================================================
" Statusline
"============================================================================
set laststatus=2        " Always put a status line

"============================================================================
" Search and Replace
"============================================================================
set noincsearch         " Don't show partial matches as search is entered
set hlsearch            " Highlight search patterns
set ignorecase          " Ignore case distinction when searching
set smartcase           " ... unless there are capitals in the search string.
"set nowrapscan         " Don't wrap to top of buffer when searching



set nu
set cursorline
set tabstop=4
set shiftwidth=4




" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif





augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END


