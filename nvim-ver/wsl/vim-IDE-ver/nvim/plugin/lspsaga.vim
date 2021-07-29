
" lspsaga keymap
" -- lsp provider to find the cursor word definition and reference
" nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
" -- or use command LspSagaFinder
nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent><M-h> :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gn :Lspsaga rename<CR>
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>z= :Lspsaga code_action<CR>
