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

local paletter_status_ok, palette = pcall(require, "rose-pine.palette")
if not paletter_status_ok then
    return
end

devicons.setup {
    default = true
}

theme.setup {
    dark_variant                     = 'moon',
    disable_float_background         = true,
    extend_background_behind_borders = false,
    highlight_groups                 = {
        BufferInactive = { bg = 'surface', fg = 'muted' },
    },
    styles                           = {
        transparency = true,
    }
}

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not colorscheme_status_ok then
    return
end

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a273f"  })
