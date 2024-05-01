

M = {}

-- Load module, print error if it could not load
M.load_module = function(module_name)
    local status, loaded_module = pcall(require, module_name)
    if not status then
        vim.api.nvim_err_writeln(
            "Error loading file: " .. 
            module_name .. "\n\n" .. 
            loaded_module
        )
    end

    return status, loaded_module
end -- load_module


return M
