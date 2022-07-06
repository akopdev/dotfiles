#!/usr/bin/env bash

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
  brew list "${1}" &> /dev/null
}

pkg_install() {
  info "Installing ${1} ..."
  if ! check_if_pkg_installed "${1}"; then
    brew install "${1}" || abort "Failed to install ${1}."
  fi
}

pkg_update() {
  info "Update ${1} ..."
  if ! check_if_pkg_installed "${1}"; then
    pkg_install "${1}"
  else
    brew upgrade "${1}" || abort "Failed to update ${1}."
  fi
}

apt_install() {
  sudo apt-get update && sudo apt-get install -y "$@"
}

check_if_installed() {
  command -v "${1}" &> /dev/null
}
