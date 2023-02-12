require("neo-tree")

-- vim.cmd [[packadd nvim-tree.lua]]

vim.o.termguicolors = true

vim.g.nvim_tree_allow_resize = 1

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings for nvimtree

vim.api.nvim_set_keymap(
    "n",
    "<C-n>",
    ":Neotree toggle<CR>",
    {
        noremap = true,
        silent = true
    }
)

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
    source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
            filesystem = " File",
            buffers = " Bufs",
            git_status = " Git",
            diagnostics = " Diagnostic",
        },
    },
    close_if_last_window = false, -- Close if last window
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
        indent = {
            indent_size = 2,
            with_markers = true,
        },
        name = {
            trailing_slash = true,
        },
    },
    window = {
        mappings = {
            ["<CR>"] = "open",
            ["<C-v>"] = "open_vsplit",
            ["a"] = {
                "add",
            },
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["R"] = "refresh",
        }
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
        },
    },
})
