local cmp = require("cmp")

cmp.setup({
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged
        },
        completeopt = "menu,menuone,noinsert"
    },
    sources = {
        { name = "nvim_lsp", priority = 100 },
        { name = "buffer" },
    },
    experimental = {
        ghost_text = true
    }
})
