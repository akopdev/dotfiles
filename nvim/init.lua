---------------------------------------------------- BOOTSTRAP ----------------------------------------------------
require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself

    "terrortylor/nvim-comment";
    "windwp/nvim-autopairs";
    "lewis6991/gitsigns.nvim";

    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/cmp-vsnip";
    "hrsh7th/vim-vsnip";
    "hrsh7th/nvim-cmp";

    "airblade/vim-gitgutter";
    "plasticboy/vim-markdown";
    "ryanoasis/vim-devicons";
    "kyazdani42/nvim-web-devicons";
    "nvim-treesitter/nvim-treesitter";
    "nvim-lua/popup.nvim";
    "nvim-lua/plenary.nvim";
    "nvim-telescope/telescope.nvim";
    "kyazdani42/nvim-tree.lua";
    "RishabhRD/popfix";
    "lukas-reineke/indent-blankline.nvim";
    "glepnir/dashboard-nvim";
    "tpope/vim-fugitive";

    "neovim/nvim-lspconfig";
    "williamboman/nvim-lsp-installer";
    "sheerun/vim-polyglot";

    "rose-pine/neovim";
    "romgrk/barbar.nvim";
    "mvllow/modes.nvim";
    "hoob3rt/lualine.nvim";
}

-------------------------------------------------- BASE SETTINGS --------------------------------------------------

vim.cmd 'filetype plugin on'
vim.opt.number = true
vim.opt.ruler = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.backspace = {'indent','eol','start'}
vim.opt.scrolloff = 3
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.laststatus = 2
vim.opt.pumheight = 10
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.diffopt = vim.opt.diffopt + 'vertical'
vim.opt.conceallevel = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldenable = false
vim.opt.breakindent = true
vim.o.title = true
vim.o.titlestring = "%{substitute(getcwd(), '.*/', '', '')}"

vim.g.mapleader = ' '

-- Use case insensitive search, except when using capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
vim.g.nostartofline = true

-- Better command-line completion
vim.opt.wildmenu = true

-- Setup python host 
vim.g.python3_host_prog = "/usr/local/bin/python3"

------------------------------------------------------ THEMES------------------------------------------------------

vim.opt.background = 'dark'
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
vim.g.onedark_terminal_italics = 1

require("nvim-web-devicons").setup ({
 default = true;
})

vim.g.rose_pine_variant = 'moon'
vim.cmd 'colorscheme rose-pine'


-------------------------------------------------- KEY BINDINGS --------------------------------------------------- 

-- Tab in general mode will move to text buffer
local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- Shortcut to save changes
map('n',  '<leader>w',      ':w<CR>',                            opts)
map('n',  'qq',             ':q<CR>',                            opts)

-- Quicker window movement
map('n', '<leader>j',       '<C-w>j',                            opts)
map('n', '<leader>k',       '<C-w>k',                            opts)
map('n', '<leader>h',       '<C-w>h',                            opts)
map('n', '<leader>l',       '<C-w>l',                            opts)

-- Terminal shortcuts
map('t', '<Esc>',           '<C-\\><C-N>',                       opts)
map('n', '<leader>t',       ':term<CR>i',                        opts)

-- Better tabbing
map('v', '<',               '<gv',                               opts)
map('v', '>',               '>gv',                               opts)
map('v', '<S-Tab>',         '<gv',                               opts)
map('v', '<Tab>',           '>gv',                               opts)
map('n', '>',               'v><Esc>',                           opts)
map('n', '<',               'v<<Esc>',                           opts)

-- Duplicate and remove rows
map('n', 'dd',              '"_dd',                              opts)
map('n', '<C-d>',           'Yp',                                opts)

-- Quicker right-hand navigation
map('',  '<S-k>',           '5k',                                opts)
map('',  '<S-j>',           '5j',                                opts)
map('',  '<S-h>',           'b',                                 opts)
map('',  '<S-l>',           'e<Right>',                          opts)

-- Beginning and end rows
map('n', '<C-l>',           '$l',                                opts)
map('i', '<C-l>',           '<C-o>$',                            opts)
map('n', '<C-h>',           '0',                                 opts)
map('i', '<C-h>',           '<C-o>0',                            opts)

-- Move lines
map('n', '<C-j>',           ':m .+1<CR>==',                      opts)
map('n', '<C-k>',           ':m .-2<CR>==' ,                     opts)
map('i', '<C-j>',           '<Esc>:m .+1<CR>==gi',               opts)
map('i', '<C-k>',           '<Esc>:m .-2<CR>==gi',               opts)
map('v', '<C-j>',           ':m \'>+1<CR>gv=gv',                 opts)
map('v', '<C-k>',           ':m \'<-2<CR>gv=gv',                 opts)

-- Copy
map('n', 'y',               'wbvey',                             opts)
map('n', 'Y',               'yy',                                opts)

-- Paste to a new line     
map('v', 'p',               '"0p',                               opts)
map('n', 'P',               ':pu<CR>',                           opts)

-- highlight
map('',  's',               '*N',                                opts)

-- Save sessions
map('',  '<leader>ss',      ':SessionSave<CR>',                  opts)

-- Tree file explorer
map('n', '<C-n>',           ':NvimTreeToggle<CR>',               opts)

-- Buffers
map('n', '<Esc>',           ':noh<CR>',                          opts)
map('n', '<Tab>',           ':BufferNext<CR>',                   opts)
map('n', '<S-Tab>',         ':BufferPrevious<CR>',               opts)
map('n', '<C-t>',           ':enew<CR>i',                        opts)

-- Close buffer
map('t', '<C-w>',           '<C-\\><C-N><CR>:BufferClose!<CR>',  opts)
map('n', '<C-w>',           ':BufferClose<CR>',                  opts) 

-- Select a word under cursor 
map('n', '<leader>v',       'viw',                               opts)

-- Bakespace in normal mode
map('n', '<BS>',            '"_x',                               opts)
map('v', '<BS>',            '"_x',                               opts)

-- Comments
map('n', '<leader>c',       ':CommentToggle<CR>',                opts)
map('v', '<leader>c',       ':CommentToggle<CR>',                opts)


------------------------------------------------- PLUGIN SETTINGS ------------------------------------------------- 
--
-- Barbar
--

vim.g.bufferline = {
    icons = false,
    tabpages = true,
    icon_separator_active = '',
    icon_separator_inactive = '',
}

-- 
-- nvim-cmp
--

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.g.vsnip_snippet_dir = '~/.config/nvim/vsnip'

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
        }, 
        {
            { name = 'buffer' },
        }
    )
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})


-- 
-- Dashboard
-- 

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    c = {description = {'  Find File          '}, command = 'Telescope find_files'},
    d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    e = {description = {'  Edit config        '}, command = 'cd ~/.dotfiles/ | edit nvim/init.lua'},
}

-- 
-- GitSigns
--
require('gitsigns').setup {
  keymaps = {
    noremap = true,
    buffer = true,
    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  current_line_blame = true,
}


--
-- Indent Blankline
--

vim.opt.colorcolumn = "9999" -- Fix for cursorline

require("indent_blankline").setup ({
    use_treesitter = true,
    space_char_blankline = " ",
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    filetype_exclude = {'help', 'dashboard', 'markdown'},
    buftype_exclude = {"terminal"},
})

-- 
-- LSP Config
--

require('nvim-lsp-installer').settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "dockerls", "ansiblels" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Add kubernetes auto completion
nvim_lsp["yamlls"].setup {
    on_attach = on_attach,
    settings = {
        yaml = {
           schemas = { kubernetes = "*.yaml" },
      }
    } 
}
-- Customizing how diagnostics are displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
})

--
-- Lualine
--

require('lualine').setup({
    options = {
        theme = 'rose-pine',
    },
    extensions= {'fugitive', 'fzf', 'nvim-tree'},
    sections = {
      lualine_a = {'mode'},
      lualine_b = {},
      lualine_c = { 
        {
          'filename',
          file_status = false, -- displays file status (readonly status, modified status)
          path = 1             -- 0 = just filename, 1 = relative path, 2 = absolute path
        }
      },
      lualine_x = {},
      lualine_y = {'diff'},
      lualine_z = {'branch'}
    }
})

-- 
-- Modes
--

require('modes').setup({
  colors = {
    copy = "#f5c359",
    delete = "#c75c6a",
    insert = "#78ccc5",
    visual = "#9745be",
  },
  line_opacity = 0.2
})

--
-- nvim-autopairs
--

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- 
-- Telescope
--

map('n', '<leader>f',  '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>ff', '<cmd>Telescope find_files theme=get_ivy<cr>', opts) 
map('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', opts)
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', opts)
map('n', '<leader>gs', '<cmd>Telescope git_status<cr>', opts)
map('n', '<leader>d',  '<cmd>Telescope lsp_document_diagnostics theme=get_ivy<cr>', opts)
map('n', '<leader>a',  '<cmd>Telescope lsp_code_actions theme=get_ivy<cr>', opts)

local actions = require('telescope.actions')
require('telescope').setup({
  pickers = {
    find_files = {
        hidden = true
    },
  },
  defaults = {
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    color_devicons = true,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
        i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
            ["<CR>"]  = actions.select_default + actions.center
        },
        n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.smart_send_to_qflist + actions.open_qflist,
        }
    }
  },
})

--
-- Tree sitter
--

require('nvim-treesitter.configs').setup ({
  ensure_installed = { "bash", "css", "go", "graphql", "html", "javascript", "jsdoc", "json", "jsonc", "php", "python", "regex", "ruby", "scss", "rust", "swift", "toml", "tsx", "typescript", "vue", "yaml" } , -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  },
})

--
-- Neovim tree
--
-- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' } -- List of filenames that gets highlighted with NvimTreeSpecialFile

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require('nvim-tree').setup ({
  -- disables netrw completely
  disable_netrw       = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  hijack_cursor       = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually) 
  update_cwd          = true,
 -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 40,
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = {
          { key = "<CR>",                         cb = tree_cb("edit") },
          { key = "<leader><leader>",             cb = tree_cb("edit") },
          { key = "<S-Right>",                    cb = tree_cb("cd") },
          { key = "<C-v>",                        cb = tree_cb("vsplit") },
          { key = "<C-x>",                        cb = tree_cb("split") },
          { key = "<BS>",                         cb = tree_cb("close_node") },
          { key = "<Tab>",                        cb = tree_cb("preview") },
          { key = "i",                            cb = tree_cb("toggle_ignored") },
          { key = ".",                            cb = tree_cb("toggle_dotfiles") },
          { key = "<leader>r",                    cb = tree_cb("refresh") },
          { key = "a",                            cb = tree_cb("create") },
          { key = "d",                            cb = tree_cb("remove") },
          { key = "r",                            cb = tree_cb("rename") },
          { key = "R",                            cb = tree_cb("full_rename") },
          { key = "x",                            cb = tree_cb("cut") },
          { key = "y",                            cb = tree_cb("copy") },
          { key = "p",                            cb = tree_cb("paste") },
          { key = "Y",                            cb = tree_cb("copy_name") },
          { key = "yy",                           cb = tree_cb("copy_path") },
          { key = "gy",                           cb = tree_cb("copy_absolute_path") },
          { key = "-",                            cb = tree_cb("dir_up") },
          { key = "o",                            cb = tree_cb("system_open") },
          { key = "q",                            cb = tree_cb("close") },
          { key = "g?",                           cb = tree_cb("toggle_help") },
      }
    }
  },
  filters = {
    custom = {'.git', 'node_modules', '.cache'}
  }

})


 
--
-- nvim-comment
--
require('nvim_comment').setup({
    create_mappings = false
})
