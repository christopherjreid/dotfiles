local utils = require("user.utils")

local status_ok, telescope = utils.load_module("telescope")

if not status_ok then
    return
end

local actions
status_ok, actions = utils.load_module("telescope.actions")

if not status_ok then
    return
end

telescope.setup({
    defaults = {
        path_display = {
            truncate = {
            }
        },
    },
    mappings = {
        n = {
            ["s"] = actions.select_vertical,
            ["S"] = actions.select_horizontal
        }
    },
})
