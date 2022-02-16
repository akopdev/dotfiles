#!/usr/bin/env bash

info "Setting up git ..."
if [[ -f "${HOME}/.gitconfig" ]]; then
  info "Backup current config file"
  mv "${HOME}/.gitconfig" "${HOME}/.gitconfig.backup"
fi

cp "${DOTFILES}/git/gitconfig.local.example" "${HOME}/.gitconfig.local"

link_file ".gitconfig"
