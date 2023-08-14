local opt = vim.opt

opt.backup = false            -- Disable backup files
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.cmdheight = 2
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.mouse = "a"

opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 300
opt.writebackup = false
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.cursorline = true
opt.number = true
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes"    -- Always show the sign column
opt.wrap = false          -- Don't wrap text
opt.scrolloff = 8         -- Keep 8 lines above/below the cursor visible
opt.sidescrolloff = 8     -- Keep 8 lines left/right the cursor visible

opt.termguicolors = true

-- Use treesitter for code folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

opt.formatoptions:remove({ "c", "r", "o" }) --- Remove comment continuation

--[[local api = vim.api
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
---
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

--]]

vim.api.nvim_command("autocmd BufReadPost,FileReadPost * normal zR")


local autoCommands = {
    -- other autocommands
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    }
}

--nvim_create_augroups(autoCommands)
