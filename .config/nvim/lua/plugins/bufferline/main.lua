require('bufferline').setup({
  diagnostics = "nvim_lsp",
  diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local icon = level:match("error") and " " or " "
    return " " .. icon .. count
  end
  })