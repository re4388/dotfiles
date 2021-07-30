
" nnoremap <silent> <M-y> <cmd>:lua require("FTerm").toggle()<CR>
" nnoremap <M-e> <cmd>Telescope buffers<cr>
nnoremap <M-w> <cmd>Telescope live_grep<cr>
nnoremap <M-e> <<cmd>lua require('telescope.builtin').oldfiles()<cr>

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
 z     },
    },
  }
}

EOF
