local config = require('cosmic.config')
local g = vim.g
local icons = require('cosmic.theme.icons')
local utils = require('cosmic.utils')

-- settings
g.nvim_tree_git_hl = 1
g.nvim_tree_refresh_wait = 300

g.nvim_tree_special_files = {}

g.nvim_tree_icons = {
  default = '',
  symlink = icons.symlink,
  git = icons.git,
  folder = icons.folder,

  lsp = {
    hint = icons.hint,
    info = icons.info,
    warning = icons.warn,
    error = icons.error,
  },
}

g.nvim_tree_respect_buf_cwd = 1

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- set up args
local args = {
  auto_close = true,
  diagnostics = {
    enable = true,
  },
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  git = {
    ignore = true,
  },
}

require('nvim-tree').setup(utils.merge(args, config.nvim_tree or {}))

