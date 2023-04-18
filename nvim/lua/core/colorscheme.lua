local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then    
    return
end

local set = vim.opt

set.background = 'dark'
set.termguicolors = true
set.colorcolumn = "9999" -- Fix for cursorline

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
vim.g.onedark_terminal_italics = 1
vim.g.rose_pine_variant = 'moon'

-- Load colorscheme with A protected call
local theme_status_ok, theme = pcall(require, "rose-pine")
if not theme_status_ok then
  return
end

devicons.setup {
    default = true
}

theme.setup {
    dark_variant  = 'moon',
    disable_float_background = true,
    highlight_groups = {
        BufferInactive = { bg = 'surface', fg = 'muted'},
    }
}

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not colorscheme_status_ok then
  return
end
