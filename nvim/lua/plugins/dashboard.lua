local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

dashboard.setup {
    theme = 'doom',
    hide = {
        statusline = false,
        tabline = false,
        winbar = false
    },
    config = {
        week_header = {
           enable = true,
        },
        center = {
            {desc = 'Load Session', action = 'SessionLoad', key ='l' },
            {desc = 'Find Text', action = 'Telescope live_grep', key ='f' },
            {desc = 'Change Branch', action = 'Telescope git_branches', key = 'b'},
            {desc = 'Open Dotfiles', action = 'cd ~/.dotfiles/ | edit nvim/init.lua', key = 'c'},
            {desc = 'Quite', action = ':q', key = 'q'},
        },
    }
}
