#!/usr/bin/env bash

# shellcheck disable=SC2154
HOME=$(eval echo "~${username}")
DOTFILES="${HOME}/.dotfiles"
INSTALL_SCRIPT_VERSION="1.0.0"

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

# adduser <username>
# usermod -aG sudo <username>
EOF
exit 1
fi

if [[ ! -d "${DOTFILES}" ]]; then
  info "Download dotfiles ..."
  git clone https://github.com/akopkesheshyan/dotfiles.git "$DOTFILES" 
fi

# shellcheck source=/dev/null
source "${DOTFILES}"/install/common.sh

# Check operation system
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
  if [[ ! -f /etc/debian_version ]]; then
    abort "We support only Debian based distributives"
  fi

  IS_LINUX=1

  info "Installing core packages ..."
  # add extra repos for i3-gaps
  add-apt-repository -y ppa:regolith-linux/release
  add-apt-repository -y ppa:regolith-linux/stable
  apt_install build-essential \
              procps \
              curl \
              file \
              zsh \
              i3-gaps \
              rofi \
              feh \
              software-properties-common

  info "Installing brew package manager ..."
  yes | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # make visible to shell
  echo "eval '$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)'" >> "/home/$(whoami)/.profile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Check, if brew was installed correctly
  if ! check_if_installed "brew"; then
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

info "Setting up local folders ..."
for folder in "Projects" ".config"; do
  if [[ ! -d "${HOME}/${folder}" ]]; then 
    mkdir "${HOME}/${folder}"
  fi
done

info "Installing brew packages"
while read -r brew_package; 
do
  pkg_install "${brew_package}"
done < "${DOTFILES}"/install/brew-packages.txt

info "Installing npm packages"
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
  for file in "${DOTFILES}"/**/setup-linux.sh 
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

info "The installation was successfully completed!"
exit 0
