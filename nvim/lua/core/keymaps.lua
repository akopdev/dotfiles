vim.g.mapleader = ' '

-- Tab in general mode will move to text buffer
local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- Shortcut to save changes
map('n',  '<leader>w', ':w<CR>',                                            opts)
map('n',  'qq',        ':q<CR>',                                            opts)
-- Quicker window movement
map('n', '<leader>j',  '<C-w>j',                                            opts)
map('n', '<leader>k',  '<C-w>k',                                            opts)
map('n', '<leader>h',  '<C-w>h',                                            opts)
map('n', '<leader>l',  '<C-w>l',                                            opts)
-- Better tabbing
map('v', '<',          '<gv',                                               opts)
map('v', '>',          '>gv',                                               opts)
map('v', '<S-Tab>',    '<gv',                                               opts)
map('v', '<Tab>',      '>gv',                                               opts)
map('n', '>',          'v><Esc>',                                           opts)
map('n', '<',          'v<<Esc>',                                           opts)
-- Duplicate and remove rows
map('n', 'dd',         '"_dd',                                              opts)
map('n', '<C-d>',      'Yp',                                                opts)
-- Quicker right-hand navigation
map('',  '<S-k>',      '5k',                                                opts)
map('',  '<S-j>',      '5j',                                                opts)
map('',  '<S-h>',      'b',                                                 opts)
map('',  '<S-l>',      'e<Right>',                                          opts)
-- Beginning and end rows
map('n', '<C-l>',      '$l',                                                opts)
map('i', '<C-l>',      '<C-o>$',                                            opts)
map('v', '<C-l>',      '$',                                                 opts)
map('n', '<C-h>',      '0',                                                 opts)
map('v', '<C-h>',      '0',                                                 opts)
map('i', '<C-h>',      '<C-o>0',                                            opts)
-- Move lines
map('n', '<C-j>',      ':m .+1<CR>==',                                      opts)
map('n', '<C-k>',      ':m .-2<CR>==' ,                                     opts)
map('i', '<C-j>',      '<Esc>:m .+1<CR>==gi',                               opts)
map('i', '<C-k>',      '<Esc>:m .-2<CR>==gi',                               opts)
map('v', '<C-j>',      ':m \'>+1<CR>gv=gv',                                 opts)
map('v', '<C-k>',      ':m \'<-2<CR>gv=gv',                                 opts)
-- Copy
map('n', 'y',          'wbvey',                                             opts)
map('n', 'Y',          'yy',                                                opts)
-- Paste     
map('v', 'p',          '"_dP<Esc>',                                         opts)
map('n', 'P',          ':pu<CR>',                                           opts)
-- highlight
map('n', 's',          '*N',                                                opts)
-- Save sessions
map('n', '<leader>ss', ':SessionSave<CR>',                                  opts)
-- Tree file explorer
map('n', '<C-n>',      ':NvimTreeToggle<CR>',                               opts)
-- Buffers
map('n', '<Esc>',      ':noh<CR>',                                          opts)
map('n', '<Tab>',      ':BufferNext<CR>',                                   opts)
map('n', '<S-Tab>',    ':BufferPrevious<CR>',                               opts)
map('n', '<C-t>',      ':enew<CR>i',                                        opts)
-- Close buffer
map('t', '<C-w>',      '<C-\\><C-N><CR>:BufferClose!<CR>',                  opts)
map('n', '<C-w>',      ':BufferClose<CR>',                                  opts) 
-- Select a word under cursor 
map('n', '<leader>v',  'viw',                                               opts)
-- Backspace in normal mode
map('n', '<BS>',       '"_x',                                               opts)
map('v', '<BS>',       '"_x',                                               opts)
-- Comments
map('n', '<leader>c',  ':CommentToggle<CR>',                                opts)
map('v', '<leader>c',  ':CommentToggle<CR>',                                opts)
-- Vertical split 
map('n', '|',          ':vsplit<CR>',                                       opts)
-- Telescope
map('n', '<leader>f',  ':Telescope live_grep<CR>',                          opts)
map('n', '<leader>ff', ':Telescope find_files theme=ivy<CR>',               opts) 
map('n', '<leader>d',  ':Telescope diagnostics bufnr=0 theme=ivy<CR>',      opts)
map('n', '<leader>a',  ':Telescope lsp_code_actions theme=ivy<CR>',         opts)
map('n', '<leader>s',  ':Telescope spell_suggest theme=cursor<CR>',         opts)
map('n', '<leader>g',  ':Telescope gh gist<CR>',                            opts)
map('n', '<leader>m',  ':Telescope marks<CR>',                              opts)
-- Quickfix list
map('n', '<C-J>',      ':cn<CR>',                                           opts)
map('n', '<C-K>',      ':cp<CR>',                                           opts)
map('n', '<C-C>',      ':cclose<CR>',                                       opts)
map('n', '<C-O>',      ':copen<CR>',                                        opts)
