set tabstop=4
set softtabstop=4
set shiftwidth=4
set fileformat=unix
set colorcolumn=100
autocmd BufWritePre *.py :%s/\s\+$//e
