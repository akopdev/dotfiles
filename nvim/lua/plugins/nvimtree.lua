local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local function on_attach(bufnr)
  local api_status_ok, api = pcall(require, "nvim-tree.api")
  if not api_status_ok then
    return
  end

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<leader><leader>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<S-Right>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', '<leader>r', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'Y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
end

vim.g.nvim_tree_auto_ignore_ft = {
  'startify',
  'dashboard'
}

nvim_tree.setup {
  on_attach           = on_attach,
  disable_netrw       = false,
  hijack_cursor       = true,
  update_cwd          = true,
  open_on_tab         = true,
  update_focused_file = {
    enable     = true,
    update_cwd = false,
  },
  view                = {
    width = 40,
    adaptive_size = true,
  },
  actions             = {
    open_file = {
      quit_on_open = true
    }
  },
  renderer            = {
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
  git                 = {
    ignore = false,
  },
  filters             = {
    custom = {
      '^.git$',
      '__pycache__'
    }
  },
}
