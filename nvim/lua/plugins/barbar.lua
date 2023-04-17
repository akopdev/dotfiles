vim.g.barbar_auto_setup = false

local status_ok, barbar = pcall(require, "barbar")
if not status_ok then
    return
end

barbar.setup {
    auto_hide = false,
    icons = { 
        filetype = { 
            enabled = false 
        },
        inactive = {
            separator = {
                left = ''
            },
        },
        separator = {
            left = ''
        },
    },
    tabpages = true,
}
