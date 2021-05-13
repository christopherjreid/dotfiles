local nvim_lsp_config = require("lspconfig")
local completion = require('completion')

local clangd_on_attach = function(client, bufnr)
    buf_set_keymap(bufnr, 'n', 'H', "<Cmd>lua require'lspconfig'.clangd.switch_source_header(0)<CR>", opts)
end

-- C++ config
nvim_lsp_config.clangd.setup {
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
    update_in_insert = true,
  }
)
