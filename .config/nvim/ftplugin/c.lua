vim.api.nvim_create_autocmd("FileType *", {
    callback = function(_) vim.opt.formatoptions:remove({ "c", "r", "o" }) end,
})
