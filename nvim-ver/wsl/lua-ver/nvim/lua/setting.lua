
local o = vim.opt
local g = vim.g
local cmd = vim.cmd

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.timeoutlen = 3000
o.ttimeoutlen = 100
o.undodir = '~/.cache/nvim/undodir'
o.cursorline = false
o.foldenable = false
o.conceallevel = 2
o.mouse = 'a'
o.wildmenu = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.showmode = true
o.listchars='tab:│ ,nbsp:␣,trail:·,extends:>,precedes:<'
o.hidden = true
o.completeopt = { 'menuone', 'noselect', 'noinsert' }
o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
]]

vim.cmd("syntax on")
-- i couldn't figure out how to set the colorscheme in lua
 -- vim.cmd('colorscheme plain')

vim.cmd('au TextYankPost * lua vim.highlight.on_yank{timeout=200}')
o.background = 'dark'


-- speed up python
g.python3_host_prog = '$HOME/.pyenv/versions/3.9.1/bin/python3.9'

-- window-local options
o.number = false
o.list = true
o.wrap = false

-- buffer-local options
o.expandtab = true
