local nvim_lsp_config = require("lspconfig")
local completion = require('completion')

local common_on_attach = function(client, bufnr)
    require("completion").on_attach({})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<Cmd>lua vim.lsp.buf.declaration()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<Cmd>lua vim.lsp.buf.definition()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'sr', "<Cmd>lua vim.lsp.buf.references()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", {})

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {})
    elseif client.resolved_capabilities.document_range_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {})
  end
end

local clangd_on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'H', "<Cmd>lua require'lspconfig'.clangd.switch_source_header(0)<CR>", {})
end

local rust_analyzer_on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
end

-- C++ config
nvim_lsp_config.clangd.setup {
    on_attach = clangd_on_attach,
    cmd = {"clangd-9", "--background-index", "--clang-tidy", "--compile-commands-dir=./build/"},
--    cmd = {"docker", "exec", "-i", "-w", "/src", "nvim-devcontainer", "clangd", "--background-index", "--clang-tidy", "--path-mappings", "/home/pip/Projects/morpheus/tank=/src"},
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}

-- Python config
nvim_lsp_config.jedi_language_server.setup {
    on_attach = common_on_attach,
    cmd = { "jedi-language-server" },
    filetypes = { "python" },
}

-- Dart config
nvim_lsp_config.dartls.setup {
    on_attach = common_on_attach,
    cmd = { "dart", "--lsp" },
    filetypes = { "dart" },
}

-- Rust config
nvim_lsp_config.rust_analyzer.setup({
  on_attach=rust_analyzer_on_attach,
  settings = {
    ["rust_analyzer"] = {
        procMacro = {
            enable = false
        }
    }
  }
})

nvim_lsp_config.jedi_language_server.setup({
  on_attach=common_on_attach 
})
-- HTML/JS/CSS config
nvim_lsp_config.html.setup({})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
  }
)
