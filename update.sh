#!/usr/bin/env bash

LOG_LEVEL_EMERGENCY=10
LOG_LEVEL_ALERT=10
LOG_LEVEL_CRITICAL=10
LOG_LEVEL_ERROR=10
LOG_LEVEL_WARNING=10
LOG_LEVEL_NOTICE=10
LOG_LEVEL_INFO=10
LOG_LEVEL_DEBUG=10

LOG_LEVEL=$LOG_LEVEL_INFO

HOME=$(eval echo ~$username)
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


source ${DOTFILES}/install/common.sh

info "Pull latest version"
cd ${DOTFILES} && git pull

info "Updating brew packages"
for brew_package in `cat ${DOTFILES}/install/brew-packages.txt`
do
  pkg_update ${brew_package}
done

info "Updating npm packages"
for npm_package in `cat ${DOTFILES}/install/npm-packages.txt`
do
  npm i -g ${npm_package}
done

# Run general setup scripts
for file in $DOTFILES/**/setup.sh
do
  source $file
done

# Run OS specific scripts
if [[ ! -z "${IS_LINUX-}" ]]; then
  for file in $DOTFILES/**/setup-linux.sh 
  do
    source $file
  done
else
  for file in $DOTFILES/**/setup-osx.sh 
  do
    source $file
  done
fi

info "Update was successfully completed!"
exit 0
