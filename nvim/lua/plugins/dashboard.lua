local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

dashboard.setup {
    theme = 'hyper',
    config = {
        shortcut = {
            {desc = '  Find File', action = 'Telescope find_files', key = 'ff' },
            {desc = '  Find Word', action = 'Telescope live_grep', key ='fw' },
            {desc = '  Edit config', action = 'cd ~/.dotfiles/ | edit nvim/init.lua', key = 'c'},
        },
        project = {
            action = 'cd '
        }
    }
}
