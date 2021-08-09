echom "load wsl-v1-init.vim"
let g:mapleader = "\<Space>"

" Plugin need to put first
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/setting.vim
source ~/.config/nvim/keymap.vim


" lua require('commented').setup()
lua require("lsp-config")
colorscheme one

:ab rtfm read the the fine manual

" dd = true
" - [] ddd
" [X] foo
" autocmd FileType vimwiki b:switch_custom_definitions = [['[ ]', '[.]', '[X]']]
autocmd FileType vim let b:switch_custom_definitions = [['[ ]', '[.]', '[X]']]
" autocmd FileType vim let b:switch_custom_definitions = [['[ ]', '[.]', '[X]']]
" autocmd FileType vim let g:switch_custom_definitions =
"     \ [
"     \   ['foo', 'bar', 'baz']
"     \ ]

" vim-matchup ========={{{

let g:matchup_motion_override_Npercent = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 0
let g:matchup_matchparen_insert_timeout = 0

"}}}


" auto save plugin setting ========={{{
" ===================================

" dsiable autosave gloablly
let g:auto_save = 0
" only autosave for md file
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
  au FileType vimwiki let b:auto_save = 1
augroup END
"}}}


" treesitter setting ========={{{
" ===================================

" ref:
" https://github.com/nvim-treesitter/nvim-treesitter#language-parsers
" https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/javascript/textobjects.scm

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["ic"] = "@call.inner",
        ["ac"] = "@call.outer",
        ["ip"] = "@parameter.inner",
        -- para outter no support
        -- Or you can define your own textobjects like this
      },
    },
		move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]]"] = "@function.outer",
					["))"] = "@call.outer",
					["}}"] = "@loop.outer",
					[">>"] = "@conditional.outer",
				},
				goto_previous_start = {
					["[["] = "@function.outer",
					["(("] = "@call.outer",
					["{{"] = "@loop.outer",
					["<<"] = "@conditional.outer",
				},
			},
  },
}
EOF

"}}}


" autocmd ============={{{
" =============================
" set folding stgy for vim file
"
" augroup auto_fold_init_vim
" 	au!
" 	au Filetype vim setlocal foldlevel=0 foldmethod=marker
" augroup END


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END


" autocmd FileType typescript let b:match_words = '\<if\>::\<else\>'
" let b:match_words = '\<if\>:\<endif\>,'
" \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'}}}


" POC ============={{{


" let b:match_ignorecase=0
"     let b:match_words =
"      \  '<:>,' .
"      \  '<\@<=!--:-->,'.
"      \  '<\@<=?\k\+:?>,'.
"      \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
"      \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'.
"      \  '\<if\>::\<else\>'
"}}}
