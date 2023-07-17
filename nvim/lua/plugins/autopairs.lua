local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

autopairs.setup {
    fast_wrap = {
        map = '<C-w>',
    },
    disable_filetype = {
        "TelescopePrompt",
        "vim"
    },
}
