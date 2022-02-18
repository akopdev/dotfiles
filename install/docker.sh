#!/usr/bin/env bash

HOME="/home/$(whoami)"
DOTFILES="${HOME}/.dotfiles"

source ${DOTFILES}/install/common.sh

# Setting up local folders ...
for folder in "Projects" ".config"; do
  if [[ ! -d "${HOME}/${folder}" ]]; then 
    mkdir "${HOME}/${folder}"
  fi
done

# Installing brew packages
for brew_package in `cat ${DOTFILES}/install/brew-packages.txt`
do
  brew install ${brew_package}
done

# Installing npm packages
for npm_package in `cat ${DOTFILES}/install/npm-packages.txt`
do
  npm i -g ${npm_package}
done

# Run general setup scripts
for file in $DOTFILES/**/setup.sh
do
  source $file
done
