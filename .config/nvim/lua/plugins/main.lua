-- Install packer if not already installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup(
  function(use)
      -- Let packer manages packer
      use("wbthomason/packer.nvim")


      use("kyazdani42/nvim-tree.lua")
      use("kyazdani42/nvim-web-devicons")

      use("nvim-treesitter/nvim-treesitter")

      use("neovim/nvim-lspconfig")
      use("nvim-lua/completion-nvim")

      use({
          "nvim-telescope/telescope.nvim", 
          requires = {{"nvim-lua/popup.nvim"},
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-fzy-native.nvim"}}
        })
  end
)

