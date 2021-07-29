
call which_key#register('<space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<space>'<CR>

"init the first level
let g:which_key_map =  {
            \ 'e': 'open explorer', 
            \ 'q': 'quit', 
            \ 'qq': 'force quit all buffer', 
            \ 'r': 'reload config', 
            \ 'w': 'write', }



" let g:which_key_map.o = { 
" \ 'name' : '+Open',
" \ 's' : 'open init.vim',
" \ 't': 'open tabder in current bf path',
" \ 'k' : 'open keymap file'}
" nnoremap <leader>os :vsp $MYVIMRC<CR>
" nnoremap <leader>ok :vsp $HOME/.config/nvim/config_group/keymapping.vim<CR>

" " Opens a new tab with the current buffer's dir
" map <leader>ot :tabedit <C-r>=expand("%:p:h")<cr>/
