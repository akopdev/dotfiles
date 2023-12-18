local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
    return
end

local hooks = require "ibl.hooks"
hooks.register(
 hooks.type.WHITESPACE,
 hooks.builtin.hide_first_space_indent_level
)

indent_blankline.setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = false
    },
    whitespace = { highlight = { "Whitespace", "NonText" } },
    exclude = {
        filetypes = {
            'help',
            'dashboard',
            'markdown'
        }
    },
}

