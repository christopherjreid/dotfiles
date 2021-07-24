local nvim_lsp_config = require("lspconfig")
local completion = require('completion')

local clangd_on_attach = function(client, bufnr)
    require("completion").on_attach({})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'H', "<Cmd>lua require'lspconfig'.clangd.switch_source_header(0)<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<Cmd>lua vim.lsp.buf.declaration()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<Cmd>lua vim.lsp.buf.definition()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'sr', "<Cmd>lua vim.lsp.buf.references()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", {})
end

-- C++ config
nvim_lsp_config.clangd.setup {
    on_attach = clangd_on_attach,
    cmd = {"clangd", "--background-index", "--clang-tidy"},
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}

-- Rust config
nvim_lsp_config.rust_analyzer.setup({
  on_attach=completion.on_attach
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
  }
)
