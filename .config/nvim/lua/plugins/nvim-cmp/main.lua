local cmp = require("cmp")

cmp.setup({
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter
        },
        completeopt = "menu,menuone,noinsert,longest"
    },
    sources = {
        { name = "nvim_lsp", priority = 100 },
        { name = "buffer" },
    },
    experimental = {
        ghost_text = true
    }
})
