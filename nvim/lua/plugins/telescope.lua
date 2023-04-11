local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
  pickers = {
    find_files = {
        hidden = true
    },
  },
  defaults = {
    prompt_title = false,
    results_title = false,
    preview_title = false,
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--ignore-file $ZSH/fzf-ignore'},
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
            ["<CR>"]  = actions.select_default + actions.center
        },
        n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["J"] = actions.preview_scrolling_down,
            ["K"] = actions.preview_scrolling_up,
        }
    }
  },
}

telescope.load_extension('gh')

vim.cmd [[ autocmd User TelescopePreviewerLoaded setlocal number ]]
