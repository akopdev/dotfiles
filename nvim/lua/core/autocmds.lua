local autocmd = vim.api.nvim_create_autocmd

-- Save window position on exit
autocmd("BufWinLeave", {
    pattern = "*.*",
    command = "mkview",
})
-- Restore window position
autocmd("BufWinEnter", {
    pattern = "*.*",
    command = "silent! loadview",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.{md,txt}",
    command = "setlocal tw=80 colorcolumn=80 fo=awqtc comments+=nb:> spell"
        .. " tabstop=2 shiftwidth=2 expandtab nocursorline",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.{jscs,jshint,eslint}rc",
    command = "set filetype=json",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "aliases.local,zshrc.local,.zshrc,*/zsh/*",
    command = "set filetype=sh",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "gitconfig.local,.gitconfig",
    command = "set filetype=gitconfig",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = ".vimrc,init.vim",
    command = "set filetype=vim",
})

autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.py",
    command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4 modifiable"
})
