local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

copilot.setup({
    panel = {
        enabled = false,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "r",
            open = ""
        },
        layout = {
            position = "right", -- | top | left | right
            ratio = 0.4
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-Tab>",
            prev = "<C-S-Tab>",
            dismiss = "<C-]>",
        },
    },
    filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 16.x
    server_opts_overrides = {},
})
