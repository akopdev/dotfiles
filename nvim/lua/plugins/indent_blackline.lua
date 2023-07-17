local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup {
    use_treesitter = true,
    space_char_blankline = " ",
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
        'help',
        'dashboard',
        'markdown'
    },
    buftype_exclude = {
        "terminal"
    },
}

