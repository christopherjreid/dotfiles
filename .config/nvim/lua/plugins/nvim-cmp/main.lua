local cmp = require("cmp")

cmp.setup({
    completion = {
        --autocomplete = {
        --    cmp.TriggerEvent.TextChanged,
        --},
        completeopt = "menu,menuone,noinsert,noselect"
    },
    sources = {
        { name = "nvim_lsp", priority = 100 },
        { name = "buffer" },
        { name = "snippet" },
    },
    experimental = {
        ghost_text = true
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
--      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
--      ['<CR>'] = cmp.mapping.confirm({
--        behavior = cmp.ConfirmBehavior.Replace,
--        select = true,
--      })
    },
    preselect = cmp.PreselectMode.None
})
