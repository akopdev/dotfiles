" ===========
" = Options =
" ===========

" Line numbers
set relativenumber
set ruler

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Backspace behavior
set backspace=indent,eol,start

" Scrolling
set scrolloff=999

" Wrapping
set nowrap

" Show status line always
set laststatus=2

" Popup menu height
set pumheight=10

" Show command
set showcmd

" Allow hidden buffers
set hidden

" Command line height
set cmdheight=1

" Update time for CursorHold, etc.
set updatetime=250

" Timeout length for mapped sequences
set timeoutlen=500

" Tabs and indentation
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent

" Clipboard
set clipboard=unnamedplus

" Folding
set nofoldenable

" Line breaking indent
set breakindent

" Command line completion
set wildmenu

" Search paths (include all subdirs)
set path+=**

" Case insensitive search, unless using uppercase
set ignorecase
set smartcase

" Do not jump to start of line on some motions
set nostartofline

" ================
" = Key bindings =
" ================

" Switch to the next buffer with <Tab>
nnoremap <Tab> :bnext<CR>

" Switch to the previous buffer with <S-Tab>
nnoremap <S-Tab> :bprevious<CR>

" Open a new empty buffer with <C-t>
nnoremap <C-t> :enew<CR>i
