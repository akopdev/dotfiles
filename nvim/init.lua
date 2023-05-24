local core_modules = {
--- Core Settings ----------------------------------
    "core/plugins",
    "core/keymaps",
    "core/options",
    "core/colorscheme",
--- Plugin Configurations --------------------------
    "plugins/autopairs",
    "plugins/cmp",
    "plugins/comment",
    "plugins/dashboard",
    "plugins/gitsigns",
    "plugins/indent_blackline",
    "plugins/lsp",
    "plugins/dap",
    "plugins/lualine",
    "plugins/barbar",
    "plugins/nvimtree",
    "plugins/telescope",
    "plugins/treesitter",
    "plugins/persisted",
}

--- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    return
  end
end
