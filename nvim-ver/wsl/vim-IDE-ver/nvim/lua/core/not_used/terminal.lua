local M = {}
M.setup = function ()
    print('hihi')
    local status_ok, terminal = pcall(require, "FTerm")
    if not status_ok then
      print('FTerm not init correctly')
      return
    end

  terminal.setup({
    dimensions  = {
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5
      },
      border = 'single' -- or 'double'
  })

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  map('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>', opts)
  -- map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
end
return M
