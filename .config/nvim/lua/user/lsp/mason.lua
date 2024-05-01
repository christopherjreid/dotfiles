

local servers = {
  "bzl",
  "clangd",
  "pyright",
  "lua_ls",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("Could not load lspconfig")
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]
  local require_server_status, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_server_status then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)

end
