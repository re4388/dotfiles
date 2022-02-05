
local map = require('cosmic.utils').map
local user_plugins = require('cosmic.config')

-- Mappings for plugins that need to be lazy loaded
if not vim.tbl_contains(user_plugins.disable_builtin_plugins, 'nvim-tree') then
  require('cosmic.plugins.nvim-tree.mappings')
end

if not vim.tbl_contains(user_plugins.disable_builtin_plugins, 'auto-session') then
  require('cosmic.plugins.auto-session.mappings')
end

-- Quickfix mappings
-- map('n', '<leader>ck', ':cexpr []<cr>')
-- map('n', '<leader>cc', ':cclose <cr>')
-- map('n', '<leader>co', ':copen <cr>')
-- map('n', '<leader>cf', ':cfdo %s/')
-- map('n', '<leader>cp', ':cprev<cr>zz')
-- map('n', '<leader>cn', ':cnext<cr>zz')

-- buffer navigation
-- map('n', '<leader>bp', ':bprev<cr>')
-- map('n', '<leader>bn', ':bnext<cr>')
-- map('n', '<leader>bd', ':bdelete<cr>')

-- tab navigation
-- map('n', '<leader>tp', ':tabprevious<cr>')
-- map('n', '<leader>tn', ':tabnext<cr>')
-- map('n', '<leader>td', ':tabclose<cr>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<s-h>', ':vertical resize -2<CR>')
map('n', '<s-l>', ':vertical resize +2<CR>')
-- map('n', '<c-left>', ':vertical resize -2<CR>')
-- map('n', '<C-Right>', ':vertical resize +2<CR>')


-- https://github.com/nanotee/nvim-lua-guide

-- AndrewRadev/switch.vim and vim-scripts/ReplaceWithRegister
vim.cmd([[
  let g:switch_mapping = "<BS>"
  nmap m <Plug>ReplaceWithRegisterOperator
]])

vim.api.nvim_exec(
[[

function! BreakHere()
	s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
	call histdel("/", -1)
endfunction

]],
true)

vim.cmd([[

    inoremap jk <esc>

    vnoremap k gk
    vnoremap j gj


    nnoremap vv V
    vnoremap v <Esc>


    nnoremap ; :
    nnoremap : ;
    vnoremap : ;
    vnoremap ; :

    nnoremap <Leader>cp yap<S-}>p
    nnoremap <Leader>d m`YP``
    vnoremap <Leader>d YPgv

    nnoremap <leader>w :w<CR>
    nnoremap <leader>ww :% so<CR>
    nnoremap <Leader>qq :qa!<CR>


    nnoremap <leader>j J
    nnoremap <leader>b :<C-u>call BreakHere()<CR>

]])


-- after search, center, zz and unfolder zv
vim.cmd([[
  map n nzzzv
  map N Nzzzv
]])

-- u and U to traversal edit history
vim.cmd([[
    nnoremap U <C-r>
]])

-- align Y to D, C
vim.cmd([[
  map Y y$
]])

-- search
vim.cmd([[
    xmap <M-n> /
    nmap <M-n> /
    nnoremap <silent> <m-m> :keepjumps normal! mi*`i<CR>
]])

-- q-prefix
vim.cmd([[
    nnoremap qj 20gj
    nnoremap qk 20gk

    nnoremap qq yiw

    nmap qd daw<esc>
    nmap qs yiq

    nnoremap qq yiw
    nnoremap cc viwp

]])


-- go line begin and end
vim.cmd([[
    nnoremap qh g^
    nnoremap ql g$
    vnoremap qh g^
    vnoremap ql g$
]])

-- eaiser surrounding vim
-- don't forget you can use S in visual mode...
vim.cmd([[
    nmap q` ysiw`
    nmap q" ysiw"
    nmap q' ysiw'
    nmap qb ysiwb
    nmap qB ysiwB
    nmap qt ysiw<
    nmap q[ ysiw[
]])

-- reverse visual mode u/U mappings
-- use `vu` to change to upper case for the letter
-- I usually change from lowercase to uppercase
vim.cmd([[
  vnoremap u U
  vnoremap U u
  nnoremap gu gU
  nnoremap gU gu
]])


--Tab Out
-- https://www.reddit.com/r/vim/comments/6ga90i/tabbing_out_of_brackets_and_quotes/
vim.cmd([[
  inoremap <expr> <Tab> getline('.')[col('.')-1] =~? '[]>)}''"`]' ? '<Right>' : '<Tab>'
]])
-- " inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'

-- paste on begin and end
-- mm and `m is to mark and allow the cursour no move
-- I usually change from lowercase to uppercase
vim.cmd([[
    nnoremap qa mmA<space><esc>p`m
    nnoremap qi mmI<c-r>0<space><esc>`m
]])

-- quick move window
vim.cmd([[
    nnoremap <C-h> <C-W>h
    nnoremap <C-l> <C-W>l
    nnoremap <C-j> <C-W>j
    nnoremap <C-k> <C-W>k
]])

-- go black hole for below actions
vim.cmd([[
  nnoremap x "_x
  nnoremap d "_d
  nnoremap D "_D
  nnoremap C "_C
  nnoremap c "_c
  vnoremap d "_d
]])

-- Add blank line above and below
vim.cmd([[
    nnoremap qo  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
    nnoremap qO  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
]])


-- c prefix for cut
vim.cmd([[
  nnoremap cD D
  nnoremap cd d
  vnoremap cd d
]])



-- Better tabbing in visual mode
vim.cmd([[
    vnoremap < <gv
    vnoremap > >gv
]])

-- shift line up and down
vim.cmd([[
    nnoremap J :m .+1<CR>==
    nnoremap K :m .-2<CR>==
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv
]])


-- vim-matchup
vim.cmd([[
    let g:matchup_motion_override_Npercent = 0
    let g:matchup_matchparen_deferred = 1
    let g:matchup_matchparen_timeout = 0
    let g:matchup_matchparen_insert_timeout = 0
    nnoremap qn %
    xnoremap qn %
]])

-- terminal commmand
vim.cmd([[
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
]])













-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)
