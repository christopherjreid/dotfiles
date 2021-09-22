vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.cmd("nnoremap <SPACE> <Nop>")
vim.cmd("let mapleader=\" \"")

vim.api.nvim_set_keymap('n', '<leader>fi',
  [[<Cmd>lua require'telescope.builtin'.git_files{find_command = {'find', '-L', '--type', 'f'}, follow = true}<CR>]],
  {})
vim.api.nvim_set_keymap('n', '<leader>fn',
  [[<Cmd>lua require'telescope.builtin'.find_files{find_command = {'find', '-L', '--type', 'f', '--no-ignore'}, follow = true}<CR>]],
  {})
vim.api.nvim_set_keymap('n', '<leader>gr',
  [[<Cmd>lua require'telescope.builtin'.live_grep{}<CR>]],
  {})
vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>%!clang-format<cr>", {})

vim.api.nvim_set_keymap("n", "<S-Tab>", "<C-O>", {})
vim.api.nvim_set_keymap("n", "c-n", ":cnext", {})
vim.api.nvim_set_keymap("n", "c-p", ":cprev", {})
vim.cmd("nnoremap <SPACE> <Nop>")

vim.cmd("set completeopt=menuone,noinsert,noselect")

vim.cmd("colorscheme darcula")
vim.cmd("set termguicolors")

require("plugins/main")

require("plugins/nvim-web-devicons/main")
require("plugins/nvim-tree/main")

require("plugins/nvim-lspconfig/main")
require("plugins/completion-nvim/main")
require("plugins/vim-fugitive/main")

