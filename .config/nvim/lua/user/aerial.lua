local status_ok, aerial = pcall(require, "aerial")

if not status_ok then
    print("Could not load Aerial (Symbol Outline)")
    return
end

aerial.setup({
    backends = { "lsp", "treesitter", "lsp" },
})
