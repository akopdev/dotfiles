#!/usr/bin/env bash

info "Setting up git ..."
if [[ -f "${HOME}/.gitconfig" ]]; then
  info "Backup current config file"
  mv "${HOME}/.gitconfig" "${HOME}/.gitconfig.backup"
fi

if [[ ! -f "${HOME}/.gitconfig.local" ]]; then
  cp "${DOTFILES}/git/gitconfig.local.example" "${HOME}/.gitconfig.local"
fi

link_file ".gitconfig"
