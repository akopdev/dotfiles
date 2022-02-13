#!/usr/bin/env bash

BOLD='\033[0;1m'
GREEN='\033[1;32m'
PURPLE='\033[1;35m'
RED='\033[1;31m'
RESET='\033[0m'
YELLOW='\033[1;33m'

LOG_LEVEL_EMERGENCY=10
LOG_LEVEL_ALERT=10
LOG_LEVEL_CRITICAL=10
LOG_LEVEL_ERROR=10
LOG_LEVEL_WARNING=10
LOG_LEVEL_NOTICE=10
LOG_LEVEL_INFO=10
LOG_LEVEL_DEBUG=10

LOG_LEVEL=$LOG_LEVEL_INFO

HOME="/home/$(whoami)"
DOTFILES="${HOME}/.dotfiles"
INSTALL_SCRIPT_VERSION="1.0.0"

error() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_ERROR ]]; then
    echo -e "${RED}[X]${RESET} $*" 1>&2
  fi
}

info() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]]; then
    echo -e "${GREEN}[+]${RESET} $*" 1>&2
  fi
}

warn() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_WARNING ]]; then
    echo -e "${YELLOW}[!]${RESET} $*" 1>&2
  fi
}

abort() {
  error "$@"
  exit 1
}

link_dir() {
  if [ ! -d "${HOME}/${1}" ]; then
    ln -s "${BASH_SOURCE[1]%"/setup.sh"}" "$HOME/${1}"
  fi
}

link_file() {
  if [ ! -f "${HOME}/${1}" ]; then
    ln -s "${BASH_SOURCE[1]%"/setup.sh"}/${1}" "$HOME/${1}"
  fi
}

check_if_pkg_installed() {
  brew list ${1} &> /dev/null
}

pkg_install() {
  info "Installing ${1} ..."
  if ! check_if_pkg_installed ${1}; then
    brew install ${1} || abort "Failed to install ${1}."
  fi
}

apt_install() {
  sudo apt-get update && sudo apt-get install -y "$@"
}

check_if_installed() {
  command -v ${1} &> /dev/null
}

clear
cat << EOF
 _____        _    __ _ _           
|  __ \      | |  / _(_) |          
| |  | | ___ | |_| |_ _| | ___  ___ 
| |  | |/ _ \| __|  _| | |/ _ \/ __|
| |__| | (_) | |_| | | | |  __/\__ \ 
|_____/ \___/ \__|_| |_|_|\___||___/

by Akop Kesheshyan           v${INSTALL_SCRIPT_VERSION}

EOF

read -p "This script will make changes on your current machine, continue? " -n 1 -r
echo # add extra line after prompt
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# Should not be a root user
if [[ $(id -u) == 0 ]]; then
abort "Don't run this as root!

This is how to create a new user:

# adduser <username>
# usermod -aG sudo <username>"
fi

# Check operation system
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
  if [[ ! -f /etc/debian_version ]]; then
    abort "We support only Debian based distributives"
  fi

  IS_LINUX=1

  info "Installing core packages ..."
  apt_install build-essential \
              procps \
              curl \
              file \
              wget \
              git \
              zsh \
              software-properties-common

  info "Installing brew package manager ..."
  yes | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # make visible to shell
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/$(whoami)/.profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Check, if brew was installed correctly
  if ! check_if_installed "brew"; then
    abort "Failed to install brew package manager"
  fi

  # Change default shell to zsh
  if [[ -n "${ZSH_VERSION}" ]]; then
    info "Make zsh the default shell"
    chsh -s $(which zsh)
  fi

elif [[ "${OS}" != "Darwin" ]]; then
  abort "Not supported OS."
fi

if [[ ! -d "${DOTFILES}" ]]; then
  info "Download dotfiles ..."
  git clone --branch install https://github.com/akopkesheshyan/dotfiles.git "$DOTFILES" 
fi

info "Setting up local folders ..."
for folder in "Projects" ".config"; do
  if [[ ! -d "${HOME}/${folder}" ]]; then 
    mkdir "${HOME}/${folder}"
  fi
done

pkg_install node

info "Installing npm packages"
for npm_package in `cat ${DOTFILES}/npm-packages.txt`; do
    npm i -g ${npm_package}
done

# Run general setup scripts
for file in $DOTFILES/**/setup.sh; do
  source $file
done

# Run OS specific scripts
if [[ ! -z "${IS_LINUX-}" ]]; then
  for file in $DOTFILES/**/setup-linux.sh; do
    source $file
  done
else
  for file in $DOTFILES/**/setup-osx.sh; do
    source $file
  done
fi

info "The installation was successfully completed!"
exit 0
