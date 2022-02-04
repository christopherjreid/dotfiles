local nvim_lsp_config = require("lspconfig")

vim.lsp.set_log_level("debug")

local common_on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', "<Cmd>lua vim.lsp.buf.declaration()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld', "<Cmd>lua vim.lsp.buf.definition()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', "<Cmd>lua vim.lsp.buf.references()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lk', "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', "<Cmd>CodeActionMenu<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ln', "<Cmd>lua vim.diagnostic.goto_next()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lp', "<Cmd>lua vim.diagnostic.goto_prev()<CR>", {})

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {})
    elseif client.resolved_capabilities.document_range_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {})
  end
--  vim.api.nvim_exec([[
--    augroup lsp
--      autocmd! * <buffer>
--      autocmd! BufEnter,BufWritePost,InsertLeave <buffer> :lua vim.lsp.diagnostic.set_loclist{open_loclist=false}
--    augroup END
--  ]], false)
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
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = {"clangd", "--background-index", "-j=4", "--completion-style=detailed", "--compile-commands-dir=./build/", "--clang-tidy"},
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
  on_attach = rust_analyzer_on_attach,
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  completion = {
      addCallArgumentSnippets = false,
      postfix = {
          enable = false
      }
  },
  cmd = { "rust-analyzer", "-v", "-v", "-v"},
  filetypes = { "rust" },
  root_dir = nvim_lsp_config.util.root_pattern("Cargo.toml"),
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
