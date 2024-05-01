local utils = require("user.utils")

local status, configs = utils.load_module("nvim-treesitter.configs")

if not status then
    return
end


configs.setup({
    ensure_installed = { "bash", "c", "cmake", "cpp", "dockerfile", "lua", "make", "markdown", "python", "regex", "rust",
        "starlark", "yaml" },
    highlight = {
        enable = false,
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
        enable = false,
        extended_mode = true,
        max_file_lines = nil
    }

})
