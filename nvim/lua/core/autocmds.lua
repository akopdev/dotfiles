local autocmd = vim.api.nvim_create_autocmd

-- Save window position on exit
autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    -- use silent to avoid messages if view can't be made
    vim.cmd("silent! mkview")
  end,
})

-- Restore window position
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! loadview")
  end,
})

-- Markdown / text settings
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.txt" },
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.formatoptions = "wqc"
    vim.opt_local.comments:append("nb:>")
    vim.opt_local.spell = true

    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true

    vim.opt_local.cursorline = false
  end,
})

-- Treat *.jscs / *.jshint / *.eslintrc as JSON
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jscsrc", "*.jshintrc", "*.eslintrc" },
  callback = function()
    vim.bo.filetype = "json"
  end,
})

-- Zsh-related files as shell
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "aliases.local", "zshrc.local", ".zshrc", "*/zsh/*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Git config files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "gitconfig.local", ".gitconfig" },
  callback = function()
    vim.bo.filetype = "gitconfig"
  end,
})

-- Vim config files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".vimrc", "init.vim" },
  callback = function()
    vim.bo.filetype = "vim"
  end,
})

-- Python indentation
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.py",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.bo.modifiable = true
  end,
})
