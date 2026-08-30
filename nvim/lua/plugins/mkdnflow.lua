local status_ok, mkdnflow = pcall(require, "mkdnflow")
if not status_ok then
  return
end

mkdnflow.setup {
  mappings = {
    MkdnNextLink = false,
    MkdnPrevLink = false,
    MkdnFollowLink = false, -- Disable and use custom action
    MkdnToggleToDo = { { 'n', 'v' }, 'tt' },
    MkdnTableFormat = { { 'n' }, '<leader>cf' },
    MkdnTableFromSelection = { { 'v' }, '<leader>t' },
    MkdnCreateLink = { { 'v' }, '<leader>l' }, -- Keep default behaviour when text selected
  },
  modules = {
    bib = true,
    buffers = true,
    conceal = true,
    cursor = true,
    folds = false,
    foldtext = false,
    links = true,
    lists = true,
    maps = true,
    paths = true,
    tables = true,
    to_do = true,
    yaml = false,
    completion = true,
    notebook = true,
  },
  filetypes = {
    markdown = true,
    txt = true,
  },
  bib = {
    default_path = '~/Literature/References.bib',
    find_in_root = true,
  },
  tables = {
    type = 'grid',
    trim_whitespace = true,
    format_on_move = true,
    auto_extend_rows = true,
    auto_extend_cols = true,
    style = {
      cell_padding = 1,
      separator_padding = 1,
      outer_pipes = true,
      apply_alignment = true,
    },
  },
  links = {
    style = 'wiki',
    compact = true,
  },
  on_attach = function(bufnr)
    local opts = { buffer = bufnr }

    -- Show bibtex picker
    vim.keymap.set('n', '<leader>t', '<cmd>Mkdnflow table new 3 2<CR>', opts)
    vim.keymap.set('n', '<leader>b', '<cmd>Telescope bibtex<CR>', opts)

    -- Custom Follow Link method to support [#filename] template
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    -- Unifies linking templates cross all types of references, where
    -- external references should live in bibtex file and included with
    -- pandoc-styled link [@entry] and internal notes are using [#entry]
    vim.keymap.set('n', 'gd', function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local start_idx, end_idx, filename = line:find('%[#([^%]]+)%]')

      if start_idx and col >= (start_idx - 1) and col <= end_idx then
        vim.cmd('edit ' .. filename .. '.md')
      else
        vim.cmd('MkdnFollowLink')
      end
    end, opts)


    -- Custom create link method
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~
    -- If no text under cursor, insert an anchor to a new numeric note 
    vim.keymap.set('n', '<leader>l', function()
      local cword = vim.fn.expand('<cword>')
      if cword == '' or cword:match("^%s*$") then
        local dir = vim.fn.expand('%:p:h')
        local files = vim.fn.readdir(dir)
        local max_num = 0
        for _, fname in ipairs(files) do
          local num = fname:match('^(%d+)%.md$')
          if num then
            local n = tonumber(num)
            if n and n > max_num then max_num = n end
          end
        end
        local next_num = string.format('%02d', max_num + 1)

        local pos = vim.api.nvim_win_get_cursor(0)
        local row, col = pos[1] - 1, pos[2]
        local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
        local new_line = line:sub(1, col) .. ' [#' .. next_num .. ']' .. line:sub(col + 1)
        vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })

        vim.api.nvim_win_set_cursor(0, { pos[1], col + #next_num + 4 })
      else
        -- Word is under cursor, let Mkdnflow handle it
        vim.cmd('MkdnCreateLink')
      end
    end, opts)
  end,
}
