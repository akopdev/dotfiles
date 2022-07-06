#!/usr/bin/env bash

HOME="/home/$(whoami)"
DOTFILES="${HOME}/.dotfiles"

# shellcheck source=/dev/null
source "${DOTFILES}"/install/common.sh

# Setting up local folders ...
for folder in "Projects" ".config"; do
  if [[ ! -d "${HOME}/${folder}" ]]; then 
    mkdir "${HOME}/${folder}"
  fi
done

# Installing brew packages
while read -r brew_package; 
do
  brew install "${brew_package}"
done < "${DOTFILES}"/install/brew-packages.txt

# Installing npm packages
while read -r npm_package;
do
  npm i -g "${npm_package}"
done < "${DOTFILES}"/install/npm-packages.txt

# Run general setup scripts
for file in "$DOTFILES"/**/setup.sh
do
  # shellcheck source=/dev/null
  source "$file"
done
