local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
    auto_hide = false,
    icons = false,
    tabpages = true,
    icon_separator_active = '',
    icon_separator_inactive = '',
}
