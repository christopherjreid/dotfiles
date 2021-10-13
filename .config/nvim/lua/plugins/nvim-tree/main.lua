require("nvim-tree")

vim.cmd [[packadd nvim-tree.lua]]

vim.o.termguicolors = true

vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_allow_resize = 1

vim.g.nvim_tree_icons = {
    default = " ",
    symlink = " ",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
    },
    folder = {
        default = "",
        open = "",
        symlink = ""
   }
}

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings for nvimtree

vim.api.nvim_set_keymap(
    "n",
    "<C-n>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)

require("nvim-tree").setup({
    auto_open = true,
    auto_close = false,
    open_on_setup = true,
    open_on_tab = false,
    update_to_buf_dir = {
        enable = true,
        auto_open = true
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {}
    },
    system_open = {
        cmd = nil,
        args = {}
    },

    view = {
        auto_resize = true,
        width = 30,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                { key = "<CR>", cb = get_lua_cb("edit") },
                { key = "o", cb = get_lua_cb("edit") },
                { key = "<2-LeftMouse>", cb = get_lua_cb("edit") },
                { key = "<2-RightMouse>", cb = get_lua_cb("cd") },
                { key = "<C-]>", cb = get_lua_cb("cd") },
                { key = "<C-v>", cb = get_lua_cb("vsplit") },
                { key = "<C-x>", cb = get_lua_cb("split") },
                { key = "<C-t>", cb = get_lua_cb("tabnew") },
                { key = "<BS>", cb = get_lua_cb("close_node") },
                { key = "<S-CR>", cb = get_lua_cb("close_node") },
                { key = "<Tab>", cb = get_lua_cb("preview") },
                { key = "I", cb = get_lua_cb("toggle_ignored") },
                { key = "H", cb = get_lua_cb("toggle_dotfiles") },
                { key = "R", cb = get_lua_cb("refresh") },
                { key = "a", cb = get_lua_cb("create") },
                { key = "d", cb = get_lua_cb("remove") },
                { key = "r", cb = get_lua_cb("rename") },
                { key = "<C-r>", cb = get_lua_cb("full_rename") },
                { key = "x", cb = get_lua_cb("cut") },
                { key = "c", cb = get_lua_cb("copy") },
                { key = "p", cb = get_lua_cb("paste") },
                { key = "{c", cb = get_lua_cb("prev_git_item") },
                { key = "]c", cb = get_lua_cb("next_git_item") },
                { key = "-", cb = get_lua_cb("dir_up") },
                { key = "q", cb = get_lua_cb("close") }
            }
        }
    }
})
