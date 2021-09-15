#!/bin/zsh

DOTFILES=$(pwd -P)

# Install dependencies

brew install zsh-autosuggestions
brew install exa

# Create symlinks
ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"

