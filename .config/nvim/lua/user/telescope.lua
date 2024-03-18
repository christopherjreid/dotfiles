local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
    print("Could not load telescope")
    return
end

local actions
status_ok, actions = pcall(require, "telescope.actions")

if not status_ok then
    print("Could not load telescope.actions")
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
