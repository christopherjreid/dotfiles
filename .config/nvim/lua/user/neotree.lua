local status_ok = pcall(require, "neo-tree")

if not status_ok then
  print("NeoTree not found")
  return
end

require("neo-tree").setup(
{
  close_if_last_window = false,
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  source_selector = {
    winbar = true,
    sources = {
      { source = "filesystem" },
      { source = "buffers" },
      { source = "git_status" }
    },
  },
  filesystem = {
    follow_current_file = true,
  },
  git_status = {
    window = {
      mappings = {
          ["<Return>"] = "show_diff",
      },
    },
    commands = {
      show_diff = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.cmd([[DiffviewOpen -- ]] .. path )
      end,
    }
  },
  window = {
    position = "left",
    width = "40",
    mapping_options = {
      noremap = true,
      nowait = true
    },
    mappings = {
        ["<CR>"] = "open_with_window_picker",
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
        ["a"] = {
            "add",
            config = {
                show_path = "relative",
            },
        },
    }
  },
  sources = {
      "filesystem" ,
      "buffers" ,
      "git_status"
  },
})

vim.api.nvim_set_keymap(
    "n",
    "<leader>e",
    ":Neotree toggle<CR>",
    {
        noremap = true,
        silent = true
    }
)





