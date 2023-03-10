local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

dashboard.setup {
    theme = 'hyper',
    hide = {
        statusline = false,
        tabline = false,
        winbar = false
    },
    config = {
        shortcut = {
            {desc = '  Find', action = 'Telescope live_grep', key ='f' },
            {desc = '  Config', action = 'cd ~/.dotfiles/ | edit nvim/init.lua', key = 'c'},
            {desc = '✗  Quite', action = ':q', key = 'q'},
        },
        project = {
            action = 'cd '
        }
    }
}
