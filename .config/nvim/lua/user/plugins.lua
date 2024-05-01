local fn = vim.fn
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end


require("packer").startup(
  function(use)
    -- Plugin manager
    use("wbthomason/packer.nvim")

    -- Colorschemes
    use("folke/tokyonight.nvim")
    use("doums/darcula")
    use("sainnhe/everforest")
    use("phha/zenburn.nvim")

    use("folke/which-key.nvim")
    use({
      "folke/neoconf.nvim",
      cmd = "Neoconf"
    })

    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
      },
    })
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("saadparwaiz1/cmp_luasnip")

    -- Snippets
    use({
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    })

    -- LSP
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use({"nvimdev/lspsaga.nvim", after = "nvim-lspconfig", config = function() require("lspsaga").setup({}) end,})
    use("stevearc/aerial.nvim")

    -- File tree
    use({
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker"
      }
    })
    use("nvim-tree/nvim-web-devicons")

    -- Fuzzy finder
    use({
      "nvim-telescope/telescope.nvim",
      branch = "master",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim"
      }
    })

    -- AST parsers
    --use({
    --  "nvim-treesitter/nvim-treesitter",
    --  run = ":TSUpdate"
    --})
    --use("p00f/nvim-ts-rainbow")

    -- Git
    use("tpope/vim-fugitive")
    use("junegunn/gv.vim")
    use("lewis6991/gitsigns.nvim")
    use("sindrets/diffview.nvim")
  end
)

