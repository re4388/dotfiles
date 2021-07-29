
local g = vim.g

local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not status_ok then
  print('nvim_tree_config not init correctly')
return
end


vim.o.termguicolors = true
g.nvim_tree_side = "right"
g.nvim_tree_width = 30
g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_tab_open = 1
g.nvim_tree_allow_resize = 1
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local tree_cb = nvim_tree_config.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = {"<CR>", "o","l", "<2-LeftMouse>"}, cb = tree_cb("edit") },
}
