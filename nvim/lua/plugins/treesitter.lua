local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

nvim_treesitter.setup {
    ensure_installed = {
        "bash",
        "css",
        "go",
        "html",
        "lua",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "python",
        "regex",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "yaml"
    },
    highlight = {
        enable = true, -- false will disable the whole extension
    },
}

