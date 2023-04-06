local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
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
