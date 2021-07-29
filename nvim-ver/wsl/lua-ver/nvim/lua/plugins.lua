
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'kana/vim-textobj-entire'
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-function'
  use 'haya14busa/vim-textobj-function-syntax'
  use 'kana/vim-textobj-line'
  use 'michaeljsmith/vim-indent-object'
  use 'andymass/vim-matchup'
  use 'wellle/targets.vim'
  use 'winston0410/commented.nvim'
  use 'arcticicestudio/nord-vim'

  -- NOTE: lspconfig ONLY has configs, for people reading this :)
  use "neovim/nvim-lspconfig"
  use "wbthomason/lsp-status.nvim"

  use "onsails/lspkind-nvim"
  -- use "glepnir/lspsaga.nvim"
  -- https://github.com/rmagatti/goto-preview
  

  use {
      "folke/lsp-trouble.nvim",
      cmd = "LspTrouble",
      config = function()
        -- Can use P to toggle auto movement
        require("trouble").setup {
          auto_preview = false,
          auto_fold = true,
        }
      end,
    }

  use "kyazdani42/nvim-web-devicons"
    if not is_wsl then
      use "yamatsum/nvim-web-nonicons"
    end

  -- use { 'Shougo/defx.nvim', }
  use "kyazdani42/nvim-tree.lua"


  -- LSP

  -- use "hrsh7th/nvim-compe"
  --use 'rafamadriz/friendly-snippets'
  use 'tjdevries/astronauta.nvim'
 --: use 'hrsh7th/vim-vsnip'
 -- use 'SirVer/ultisnips'
 --- use 'honza/vim-snippets'

--:  use "hrsh7th/vim-vsnip"
-- TREE SITTER:
  use "nvim-treesitter/nvim-treesitter"


end)



