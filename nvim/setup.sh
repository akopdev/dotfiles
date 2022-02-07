#!/usr/bin/env bash
bi nvim
link_dir ".config/nvim"

info "Install plugin manager for nvim"

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

info "[TODO]: Installing LSP servers ..."


