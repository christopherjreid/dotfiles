local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
    print("Could not load treesitter")
    return
end

configs.setup({
    ensure_installed = { "bash", "c", "cmake", "cpp", "dockerfile", "lua", "make", "markdown", "python", "regex", "rust",
        "starlark", "yaml" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<Tab>',
            node_decremental = '<S-Tab>',
        }
    },
    indent = {
        enable = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }

})
