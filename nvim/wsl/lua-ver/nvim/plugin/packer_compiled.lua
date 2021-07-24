-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/re4388/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/re4388/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/re4388/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/re4388/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/re4388/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["commented.nvim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/commented.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble" },
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nord-vim"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-hint-textobject"] = {
    config = { "\27LJ\2\n¢\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0009vnoremap <silent> m :lua require('tsht').nodes()<CR>>omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-ts-hint-textobject"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-web-nonicons"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/nvim-web-nonicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-function"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-textobj-function"
  },
  ["vim-textobj-function-syntax"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-textobj-function-syntax"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-textobj-line"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/re4388/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-ts-hint-textobject
time([[Config for nvim-ts-hint-textobject]], true)
try_loadstring("\27LJ\2\n¢\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0009vnoremap <silent> m :lua require('tsht').nodes()<CR>>omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>\bcmd\bvim\0", "config", "nvim-ts-hint-textobject")
time([[Config for nvim-ts-hint-textobject]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":LspTrouble") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
