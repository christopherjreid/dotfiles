vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.cmd("nnoremap <SPACE> <Nop>")
vim.cmd("let mapleader=\" \"")

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
vim.api.nvim_set_keymap("n", "<S-Tab>", "<C-O>", {})

vim.cmd("set completeopt=menuone,noinsert,noselect")

vim.cmd("colorscheme darcula")
vim.cmd("set termguicolors")

require("plugins/main")

require("plugins/nvim-web-devicons/main")
require("plugins/nvim-tree/main")

require("plugins/nvim-lspconfig/main")
require("plugins/completion-nvim/main")
