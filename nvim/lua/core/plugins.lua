vim.pack.add({
    "https://github.com/terrortylor/nvim-comment",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/lewis6991/gitsigns.nvim",

    -- Autocompletion & Snippets
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/cmp-vsnip",
    "https://github.com/hrsh7th/vim-vsnip",
    "https://github.com/hrsh7th/nvim-cmp",

    -- UI, File Explorer, and Tools
    "https://github.com/airblade/vim-gitgutter",
    "https://github.com/plasticboy/vim-markdown",
    "https://github.com/kyazdani42/nvim-web-devicons",
    "https://github.com/nvim-lua/popup.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/kyazdani42/nvim-tree.lua",
    "https://github.com/RishabhRD/popfix",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/glepnir/dashboard-nvim",
    "https://github.com/tpope/vim-fugitive",

    -- Theme & Status/Tablines
    "https://github.com/rose-pine/neovim",
    "https://github.com/romgrk/barbar.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/yorickpeterse/nvim-pqf",

    -- Utilities
    "https://github.com/olimorris/persisted.nvim",
    "https://github.com/ray-x/lsp_signature.nvim",

    -- Debugging
    "https://github.com/nvim-telescope/telescope-dap.nvim",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",

    -- Experimental
    "https://github.com/sindrets/diffview.nvim",

    -- Note taking
    "https://github.com/jakewvincent/mkdnflow.nvim",
    "https://github.com/nvim-telescope/telescope-bibtex.nvim"

})

-- Handy command for manual plugin update
vim.api.nvim_create_user_command("PackUpdate", function()
  require("vim.pack").update()
end, { desc = "Update all plugins using native package manager" })
