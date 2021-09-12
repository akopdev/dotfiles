#!/bin/zsh

DOTFILES=$(pwd -P)

# Create symlinks
ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"

