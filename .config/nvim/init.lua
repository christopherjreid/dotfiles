

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.cmd("nnoremap <SPACE> <Nop>")
vim.cmd("let mapleader=\" \"")

vim.cmd("nnoremap <leader>ff <cmd>Telescope find_files<cr>")

require("plugins/main")

require("plugins/nvim-web-devicons/main")
require("plugins/nvim-tree/main")

require("plugins/nvim-lspconfig/main")
--require("plugins/completion-nvim/main")

