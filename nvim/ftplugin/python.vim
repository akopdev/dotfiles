set tabstop=4
set softtabstop=4
set shiftwidth=4
set modifiable
autocmd BufWritePre *.py :%s/\s\+$//e
