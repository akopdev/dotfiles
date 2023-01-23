local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.nvim_tree_auto_ignore_ft = { 
  'startify', 
  'dashboard' 
} 

nvim_tree.setup {
  disable_netrw       = false,
  hijack_cursor       = true,
  update_cwd          = true,
  open_on_tab         = true,
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
  },
  view = {
    width = 40,
    adaptive_size = false,
    mappings = {
      custom_only = true,
      list = {
          { key = "<CR>",                         cb = tree_cb "edit" },
          { key = "<leader><leader>",             cb = tree_cb "edit" },
          { key = "<S-Right>",                    cb = tree_cb "cd" },
          { key = "<C-v>",                        cb = tree_cb "vsplit" },
          { key = "<C-x>",                        cb = tree_cb "split" },
          { key = "<BS>",                         cb = tree_cb "close_node" },
          { key = "<Tab>",                        cb = tree_cb "preview" },
          { key = "i",                            cb = tree_cb "toggle_ignored" },
          { key = ".",                            cb = tree_cb "toggle_dotfiles" },
          { key = "<leader>r",                    cb = tree_cb "refresh" },
          { key = "a",                            cb = tree_cb "create" },
          { key = "d",                            cb = tree_cb "remove" },
          { key = "r",                            cb = tree_cb "rename" },
          { key = "R",                            cb = tree_cb "full_rename" },
          { key = "x",                            cb = tree_cb "cut" },
          { key = "y",                            cb = tree_cb "copy" },
          { key = "p",                            cb = tree_cb "paste" },
          { key = "Y",                            cb = tree_cb "copy_name" },
          { key = "yy",                           cb = tree_cb "copy_path" },
          { key = "gy",                           cb = tree_cb "copy_absolute_path" },
          { key = "-",                            cb = tree_cb "dir_up" },
          { key = "o",                            cb = tree_cb "system_open" },
          { key = "q",                            cb = tree_cb "close" },
          { key = "g?",                           cb = tree_cb "toggle_help" },
      }
    }
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  renderer = {
    indent_markers = {
      enable = true
    },
    icons = {
      show = {
        folder_arrow = false
      }
    },
    add_trailing = true,
    highlight_git = true,
    special_files = { 
      'README.md', 
      'Makefile', 
    },
  },
  filters = {
    custom = {
      '.git$', 
      'node_modules', 
      '.cache'
    }
  },
}
