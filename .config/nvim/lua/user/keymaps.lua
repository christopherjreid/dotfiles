local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

local which_key_queue = nil

local function which_key_register()
    if which_key_queue then
        local wk_avail, wk = pcall(require, "which-key")
        if wk_avail then
            for mode, registration in pairs(which_key_queue) do
                wk.register(registration, { mode = mode })
            end
            which_key_queue = nil
        end
    end
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
local function set_mappings(map_table, base)
    -- iterate over the first keys for each mode
    base = base or {}
    for mode, maps in pairs(map_table) do
        -- iterate over each keybinding set in the current mode
        for keymap, options in pairs(maps) do
            -- build the options for the command accordingly
            if options then
                local cmd = options local keymap_opts = base
                if type(options) == "table" then
                    cmd = options[1]
                    keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
                    keymap_opts[1] = nil
                end
                if not cmd or keymap_opts.name then -- if which-key mapping, queue it
                    if not keymap_opts.name then keymap_opts.name = keymap_opts.desc end
                    if not which_key_queue then which_key_queue = {} end
                    if not which_key_queue[mode] then which_key_queue[mode] = {} end
                    which_key_queue[mode][keymap] = keymap_opts
                else -- if not which-key mapping, set it
                    vim.keymap.set(mode, keymap, cmd, keymap_opts)
                end
            end
        end
    end
    if package.loaded["which-key"] then which_key_register() end -- if which-key is loaded already, register
end


keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local maps = { i = {}, n = {}, v = {}, t = {} }

local sections = {
    t = { desc = "Telescope" },
    l = { desc = "LSP" },
    --[[
  p = { desc = get_icon("Package", 1, true) .. "Packages" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  S = { desc = get_icon("Session", 1, true) .. "Session" },
  ]] --
}

maps.n["<leader>t"] = sections.t
maps.n["<leader>l"] = sections.l

-- Better window navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left window" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Move to down window" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Move to up window" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right window" }

-- Make terminal navigation the same
maps.t["<C-h>"] = { "<C-\\><C-N><C-w>h", desc = "Move to left window" }
maps.t["<C-j>"] = { "<C-\\><C-N><C-w>j", desc = "Move to down window" }
maps.t["<C-k>"] = { "<C-\\><C-N><C-w>k", desc = "Move to up window" }
maps.t["<C-l>"] = { "<C-\\><C-N><C-w>l", desc = "Move to right window" }

-- Resize
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Back to normal mode
keymap("i", "jk", "<ESC>", opts)

-- Search forward/backward for word under cursor
maps.n["g["] = { "g#", desc = "Jump to next occurance of word under cursor" }
maps.n["g]"] = { "g*", desc = "Jump to previous occurance of word under cursor" }

-- Keep highlight on selection when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Telescope things
maps.n["<leader>tf"] = {
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Find file"
}
maps.n["<leader>tg"] = {
    "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>", desc = "Grep" }

maps.n["<leader>tS"] = {
    "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Search workspace symbols"
}
maps.n["<leader>ts"] = {
    "<cmd>lua require'telescope'.extensions.aerial.aerial(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Search local symbols"
}
maps.n["<leader>tt"] = {
    "<cmd>lua require'telescope.builtin'.lsp_type_definitions(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Search type defs"
}
maps.n["<leader>tgs"] = {
    "<cmd>lua require'telescope.builtin'.git_status(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Git status"
}


set_mappings(maps)
