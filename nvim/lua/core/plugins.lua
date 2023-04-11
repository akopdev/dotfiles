local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use "terrortylor/nvim-comment"
    use "windwp/nvim-autopairs"
    use "lewis6991/gitsigns.nvim"

    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/nvim-cmp"
 
    use "airblade/vim-gitgutter"
    use "plasticboy/vim-markdown"
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-github.nvim"
    use "kyazdani42/nvim-tree.lua"
    use "RishabhRD/popfix"
    use "lukas-reineke/indent-blankline.nvim"
    use "glepnir/dashboard-nvim"
    use "tpope/vim-fugitive"
 
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "sheerun/vim-polyglot"
 
    use "rose-pine/neovim"
    use "romgrk/barbar.nvim"
    use "mvllow/modes.nvim"
    use "nvim-lualine/lualine.nvim"
 
    use "lewis6991/spellsitter.nvim"

    use "shatur/neovim-session-manager"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
