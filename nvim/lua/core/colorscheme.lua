local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then    
    return
end

local modes_status_ok, modes = pcall(require, "modes")
if not modes_status_ok then    
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
local theme_status_ok, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not theme_status_ok then
  return
end

devicons.setup {
    default = true
}

modes.setup{
    colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#78ccc5",
        visual = "#9745be",
    },
    line_opacity = 0.2
}
