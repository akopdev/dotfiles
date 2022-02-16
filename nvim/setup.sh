#!/usr/bin/env bash

link_dir ".config/nvim"

info "Installing plugin manager for nvim"

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

info "Setting up all neovim plugins"

pip install --user \
    neovim \
    pyright

nvim -E +PaqInstall +PaqUpdate +q
