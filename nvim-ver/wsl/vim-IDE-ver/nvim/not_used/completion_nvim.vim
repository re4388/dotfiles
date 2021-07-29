lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = ""
" Set completeopt to have a better completion experience
set completeopt=menuone,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

