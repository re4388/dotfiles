local M = {}
print("XXXXXXXXXXXXXX")
local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  print("treesitter is not working")
  return
end

M.setup = function()
  treesitter_config.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing

    highlight = {
      enable = true -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm"
      }
    },
    indent = {
      enable = true
    }
  }
end
