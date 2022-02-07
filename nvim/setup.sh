#!/usr/bin/env bash

pkg_install nvim
pkg_install go
pkg_install gopls

if [[ ! -d "${HOME}/go" ]]; then
    mkdir "${HOME}/go"
fi

link_dir ".config/nvim"

info "Installing plugin manager for nvim"

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

info "Setting up all neovim plugins"

pip install --user \
    neovim \
    pyright

nvim -E +PaqInstall +qall || true
