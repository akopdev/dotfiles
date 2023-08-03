local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

local custom_logo = {
'',
'',
'',
'    ,dPYb,              ,dPYb, ,dPYb,             ',
'    IP``Yb              IP``Yb IP``Yb             ',
'    I8  8I              I8  8I I8  8I             ',
'    I8  8               I8  8" I8  8"             ',
'    I8 dPgg,    ,ggg,   I8 dP  I8 dP    ,ggggg,   ',
'    I8dP" "8I  i8" "8i  I8dP   I8dP    dP"  "Y8ggg',
'    I8P    I8  I8, ,8I  I8P    I8P    i8`    ,8I  ',
'   ,d8     I8, `YbadP` ,d8b,_ ,d8b,_ ,d8,   ,d8`  ',
'   88P     `Y8888P"Y8888P`"Y888P`"Y88P"Y8888P"   ',
'',
'',
'',
}

dashboard.setup {
    theme = 'doom',
    hide = {
        statusline = false,
        tabline = false,
        winbar = false
    },
    config = {
        header = custom_logo,
        center = {
            { desc = 'Load Session',  action = 'SessionLoad',                          key = 'l' },
            { desc = 'Find Text',     action = 'Telescope live_grep',                  key = 'f' },
            { desc = 'Change Branch', action = 'Telescope git_branches',               key = 'b' },
            { desc = 'Open Dotfiles', action = 'cd ~/.dotfiles/ | edit nvim/init.lua', key = 'c' },
            { desc = 'Quite',         action = ':q',                                   key = 'q' },
        },
    }
}
