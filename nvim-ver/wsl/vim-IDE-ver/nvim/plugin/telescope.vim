
nnoremap <M-w> <cmd>Telescope live_grep<cr>


" https://github.com/nvim-telescope/telescope.nvim#pickers
nnoremap <M-e> <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader><leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader><leader>tt <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader><leader>mm <cmd>lua require('telescope.builtin').keymaps()<cr>

" change to toggle exploer in kyazdani42/nvim-tree.lua
" nnoremap <M-f> <cmd>Telescope file_browser<cr>

lua << EOF

local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 80
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
