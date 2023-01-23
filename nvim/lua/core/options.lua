local set = vim.opt

set.spell = true
set.spelllang = { 'en_gb' }
set.number = true
set.ruler = true
set.encoding = 'utf-8'
set.fileencoding = 'utf-8'
set.backspace = {'indent','eol','start'}
set.scrolloff = 3
set.wrap = false
set.cursorline = true
set.showtabline = 2
set.laststatus = 2
set.pumheight = 10
set.showcmd = true
set.hidden = true
set.cmdheight = 1
set.updatetime = 250
set.timeoutlen = 500
set.splitbelow = true
set.splitright = true
set.diffopt = vim.opt.diffopt + 'vertical'
set.conceallevel = 0
set.tabstop = 2
set.shiftwidth = 2
set.smarttab = true
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.clipboard = 'unnamedplus'
set.foldenable = false
set.breakindent = true
set.wildmenu = true -- Better command-line completion

-- Use case insensitive search, except when using capital letters
set.ignorecase = true
set.smartcase = true

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
vim.g.nostartofline = true

local status_ok, _ = pcall(vim.cmd, "filetype plugin on")
if not status_ok then
  return
end

-- Setup python host 
-- vim.g.python3_host_prog = "/usr/local/bin/python3"
