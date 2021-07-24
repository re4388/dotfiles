function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
  return ...
end

print("util.lua loading")
-- local o = vim.o -- global option
-- local wo = vim.wo -- local windows option
-- local bo = vim.bo -- local buffer option
-- wo.number = true
-- wo.relativenumber = true
-- local map = vim.api.nvim_set_keymap
-- options = { noremap = true}
-- map('n', '<leader><esc>', ':nohlsearch<cr>', options)
-- map('number')
