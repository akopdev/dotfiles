#!/usr/bin/env bash

# shellcheck disable=SC2154
HOME=$(eval echo "~${username}")
DOTFILES="${HOME}/.dotfiles"
SCRIPT_VERSION="1.0.0"

clear
cat << EOF
 _____        _    __ _ _           
|  __ \      | |  / _(_) |          
| |  | | ___ | |_| |_ _| | ___  ___ 
| |  | |/ _ \| __|  _| | |/ _ \/ __|
| |__| | (_) | |_| | | | |  __/\__ \ 
|_____/ \___/ \__|_| |_|_|\___||___/

by Akop Kesheshyan           v${SCRIPT_VERSION}

EOF

read -p "This script will update your local packages, continue? " -n 1 -r
echo # add extra line after prompt
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# Should not be a root user
if [[ $(id -u) == 0 ]]; then
echo "Don't run this as root!"
exit 1
fi

# Check if dotfiles exists
if [[ ! -d "${DOTFILES}" ]]; then
echo "'${DOTFILES}' not found. Please, run install.sh first!"
exit 1
fi

# shellcheck source=/dev/null
source "${DOTFILES}"/install/common.sh

info "Pull latest version"
cd "${DOTFILES}" && git pull

info "Updating brew packages"
while read -r brew_package; 
do
  pkg_update "${brew_package}"
done < "${DOTFILES}"/install/brew-packages.txt

info "Updating npm packages"
while read -r npm_package;
do
  npm i -g "${npm_package}"
done < "${DOTFILES}"/install/npm-packages.txt

# Run general setup scripts
for file in "${DOTFILES}"/**/setup.sh
do
  # shellcheck source=/dev/null
  source "$file"
done

# Run OS specific scripts
if [[ -n "${IS_LINUX-}" ]]; then
  for file in "$DOTFILES"/**/setup-linux.sh 
  do
  # shellcheck source=/dev/null
    source "$file"
  done
else
  for file in "${DOTFILES}"/**/setup-osx.sh 
  do
  # shellcheck source=/dev/null
    source "$file"
  done
fi

info "Update was successfully completed!"
exit 0
