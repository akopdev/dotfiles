vim.g.mapleader = ' '

local map = vim.keymap.set
local opts = { noremap = true }

-- Shortcut to save changes
map('n', '<leader>w', ':w<CR>', opts)
map('n', 'qq', ':q<CR>', opts)
map('n', 'qa', ':qall<CR>', opts)
-- Quicker window movement
map('n', '<leader>j', '<C-w>j', opts)
map('n', '<leader>k', '<C-w>k', opts)
map('n', '<leader>h', '<C-w>h', opts)
map('n', '<leader>l', '<C-w>l', opts)
map('n', '<leader>J', ':resize -10<CR>', opts)
map('n', '<leader>K', ':resize +10<CR>', opts)
map('n', '<leader>H', ':vertical resize +10<CR>', opts)
map('n', '<leader>L', ':vertical resize -10<CR>', opts)
-- Better tabbing
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)
map('v', '<Tab>', '>gv', opts)
map('n', '>', 'v><Esc>', opts)
map('n', '<', 'v<<Esc>', opts)
-- Duplicate and remove rows
map('n', 'dd', '"_dd', opts)
map('n', '<C-d>', 'Yp', opts)
-- Quicker right-hand navigation
map('', '<S-k>', '5k', opts)
map('', '<S-j>', '5j', opts)
map('', '<S-h>', 'b', opts)
map('', '<S-l>', 'e<Right>', opts)
-- Beginning and end rows
map('n', '<C-l>', '$l', opts)
map('i', '<C-l>', '<C-o>$', opts)
map('v', '<C-l>', '$', opts)
map('n', '<C-h>', '^', opts)
map('v', '<C-h>', '^', opts)
map('i', '<C-h>', '<C-o>^', opts)
-- Move lines
map('n', '<C-j>', ':m .+1<CR>==', opts)
map('n', '<C-k>', ':m .-2<CR>==', opts)
map('i', '<C-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<C-k>', '<Esc>:m .-2<CR>==gi', opts)
map('v', '<C-j>', ':m \'>+1<CR>gv=gv', opts)
map('v', '<C-k>', ':m \'<-2<CR>gv=gv', opts)
-- Copy
map('n', 'y', 'wbvey<Esc>', opts)
map('n', 'Y', 'yy', opts)
-- Paste
map('v', 'p', '"_di<C-R>"<Esc>', opts)
-- Delete word word but don’t save it anywhere
map('n', 'diw', '"_diw', opts)
-- highlight
map('n', 's', '*N', opts)
-- Save sessions
map('n', '<leader>ss', ':SessionSave<CR>', opts)
-- Tree file explorer
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
-- Buffers
map('n', '<Esc>', ':noh<CR>', opts)
map('n', '<Tab>', ':BufferNext<CR>', opts)
map('n', '<S-Tab>', ':BufferPrevious<CR>', opts)
map('n', '<C-t>', ':enew<CR>i', opts)
-- Close buffer
map('n', '<C-w>', ':BufferClose<CR>', opts)
-- Select a word under cursor
map('n', 'vv', 'viw', opts)
-- Backspace in normal mode
map('n', '<BS>', '"_x', opts)
map('v', '<BS>', '"_x', opts)
-- Comments
map('n', '<leader>c', ':CommentToggle<CR>', opts)
map('v', '<leader>c', ':CommentToggle<CR>', opts)
-- Vertical split
map('n', '|', ':vsplit<CR>', opts)
map('n', '-', ':split<CR>', opts)
-- Telescope
map('n', '<leader>f', ':Telescope live_grep<CR>', opts)
map('n', '<leader>ff', ':Telescope find_files theme=ivy previewer=false<CR>', opts)
map('n', '<leader>cd', ':Telescope diagnostics bufnr=0 theme=ivy<CR>', opts)
map('n', '<leader>ca', ':Telescope lsp_code_actions theme=ivy<CR>', opts)
map('n', '<leader>gg', ':Telescope gh gist<CR>', opts)
map('n', '<leader>gb', ':Telescope git_branches<CR>', opts)
map('n', '<leader>q', ':Telescope quickfix<CR>', opts)
map('n', '<leader>r', ':Telescope command_history<CR>', opts)
-- Quickfix list
map('n', 'qj', ':cn<CR>', opts)
map('n', 'qk', ':cp<CR>', opts)
-- LSP
map('n', 'gd', ':Telescope lsp_definitions<CR>', opts)
map('n', 'gr', ':Telescope lsp_references<CR>', opts)
map('n', 'gi', ':Telescope lsp_implementations<CR>', opts)
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opts)
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
map("n", "<leader>cf", ':lua vim.lsp.buf.format({ async = true })<CR>', opts)

map('n', '<leader>dr', ':lua require("dap").continue()<CR>', opts)
map('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', opts)
map('n', '<leader>do', ':lua require("dap").repl.open()<CR>', opts)
map('n', '<leader>dn', ':lua require("dap").step_into()<CR>', opts)

-- GitSigns

map('n', '<leader>gu', ':lua require"gitsigns".reset_hunk()<CR>', opts)
map('n', '<leader>gp', ':lua require"gitsigns".preview_hunk()<CR>', opts)

-- Toggle between geek and normal modes
local function toggleLineNumbers()
    vim.opt.number = true
    vim.opt.relativenumber = not vim.wo.relativenumber
end

vim.keymap.set("n", "<leader>n", toggleLineNumbers, opts)
