local api = vim.api
local buf, win

local function open_window()
  buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_option()

  -- body
end
