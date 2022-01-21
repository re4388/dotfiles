
" nnoremap <M-w> <cmd>Telescope live_grep<cr>
" https://github.com/nvim-telescope/telescope.nvim#pickers
" nnoremap <M-e> <cmd>lua require('telescope.builtin').oldfiles()<cr>


" nnoremap <leader><leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>
" nnoremap <leader><leader>tt <cmd>lua require('telescope.builtin').colorscheme()<cr>
" nnoremap <leader><leader>mm <cmd>lua require('telescope.builtin').keymaps()<cr>


" change to toggle exploer in kyazdani42/nvim-tree.lua
" nnoremap <M-f> <cmd>Telescope file_browser<cr>
" nnoremap <M-p> <cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>

" require'telescope'.extensions.project.project{}

" on project setting, see: https://github.com/nvim-telescope/telescope-project.nvim

" Lists files in your current working directory, respects .gitignore
nnoremap <M-e> <cmd>lua require('telescope.builtin').find_files()<cr>


" Searches for the string under your cursor in your current working directory
" nnoremap <M-w> <cmd>lua require('telescope.builtin').grep_string()<cr>


" Search for a string in your current working directory and get results live as you type (respecting .gitignore)
nnoremap <M-w> <cmd>lua require('telescope.builtin').live_grep()<cr>

" vim.api.nvim_set_keymap(
"     'n',
"     '<M-p>',
"     ":lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>",
"     {noremap = true, silent = true}
" )
" require'telescope'.load_extension('project')



" layout_strategy = "horizontal",


lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        preview_width = 120
        }
    },
    mappings = {
      i = {
        ["q"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
      n = {
        ["q"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
  }
}
EOF
