local nvim_lsp_config = require("lspconfig")

local clangd_on_attach = function(client, bufnr)
    buf_set_keymap(bufnr, 'n', 'H', "<Cmd>lua require'lspconfig'.clangd.switch_source_header(0)<CR>", opts)
end

--C++ config
nvim_lsp_config.clangd.setup {
    cmd = {"clangd", "--background-index", "--clang-tidy"},
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
