local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

dashboard.default_executive = 'telescope'
dashboard.custom_center = {
    {desc = '  Load Last Session  ', action = 'SessionLoad'},
    {desc = '  Recently Used Files', action = 'Telescope oldfiles'},
    {desc = '  Find File          ', action = 'Telescope find_files'},
    {desc = '  Find Word          ', action = 'Telescope live_grep'},
    {desc = '  Edit config        ', action = 'cd ~/.dotfiles/ | edit nvim/init.lua'},
}