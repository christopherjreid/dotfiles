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
        { name = "nvim_lsp" },
        { name = "buffer" },
    }

})
