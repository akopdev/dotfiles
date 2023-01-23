local status_ok, autopairs = pcall(require, "nvim-autopais")
if not status_ok then
    return
end

autopairs.setup {
    disable_filetype = { 
        "TelescopePrompt" , 
        "vim" 
    },
}