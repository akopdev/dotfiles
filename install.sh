#!/usr/bin/env bash

# shellcheck disable=SC2154
HOME=$(eval echo "~${username}")
DOTFILES="${HOME}/.dotfiles"
INSTALL_SCRIPT_VERSION="1.0.0"

GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'
YELLOW='\033[1;33m'

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
cat << EOF
Don't run this as root!

This is how to create a new user:

adduser <username>
usermod -aG sudo <username>
EOF
exit 1
fi

# shellcheck source=/dev/null
source "${DOTFILES}"/install/common.sh

# Check operation system
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
  if [[ ! -f /etc/debian_version ]]; then
    abort "We support only Debian based distributives"
  fi

  info "Installing core packages ..."
  sudo apt-get update && \
  sudo apt-get install -y build-essential git curl zsh

  info "Installing brew package manager ..."
  yes | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # make visible to shell
  echo "eval '$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)'" >> "${HOME}/.profile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Check, if brew was installed correctly
  if ! command -v "brew" &> /dev/null; then
    abort "Failed to install brew package manager"
  fi

  # Change default shell to zsh
  if [[ -n "${ZSH_VERSION}" ]]; then
    info "Make zsh the default shell"
    chsh -s "$(which zsh)"
  fi

elif [[ "${OS}" != "Darwin" ]]; then
  abort "Not supported OS."
fi

if [[ ! -d "${DOTFILES}" ]]; then
  info "Download dotfiles ..."
  git clone https://github.com/akopdev/dotfiles.git "${DOTFILES}" 
fi


info "Setup required folders."
mkdir -p "${HOME}"/{Projects,.config}
source "${DOTFILES}/bin/dotfiles"
_install_config_files

info "Install all packages."
zsh -c dotfiles update

info "The installation was successfully completed!"
