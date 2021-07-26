local luadev = require("lua-dev").setup({})

local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup(luadev)

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand("$USER")
-- re4388
-- print('user', USER)
local sumneko_root_path = ""
local sumneko_binary = ""
if vim.fn.has("unix") == 1 then
  sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
  sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
  print("Unsupported system for sumneko")
end

require "lspconfig".sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup lua path
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- For language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
        },
        maxPreload = 100000,
        preloadFileSize = 1000
      }
    }
  }
}