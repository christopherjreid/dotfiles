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
      use("doums/darcula")
      use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu"
      })
      use("kyazdani42/nvim-tree.lua")
      use("kyazdani42/nvim-web-devicons")

      use("nvim-treesitter/nvim-treesitter")

      use("neovim/nvim-lspconfig")
      use("hrsh7th/nvim-cmp")
      use("hrsh7th/cmp-nvim-lsp")
      use("hrsh7th/cmp-buffer")

      use({
          "nvim-telescope/telescope.nvim", branch = 'master',
          requires = {
            {"nvim-lua/popup.nvim"},
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-fzy-native.nvim"}
          }
        })
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")
    use("nvim-lualine/lualine.nvim")
    --use("simrat39/rust-tools.nvim")
    use({"folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
          require("trouble").setup({})
      end
    })
  end
)

