-- Vim Fugitive
vim.api.nvim_set_var("fugitive_no_maps", 1)
vim.api.nvim_set_keymap('n', '<leader>gb', '<Cmd>Git blame<CR>', {})
vim.api.nvim_set_keymap('n', '<C-G>f', '<Cmd>Git fetch<CR>', {})
vim.api.nvim_set_keymap('n', '<C-G>p', '<Cmd>Git push<CR>', {})
vim.api.nvim_set_keymap('n', '<C-G>c', '<Cmd>Git commit<CR>', {})
