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


error() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_ERROR ]]; then
    echo -e "${RED}[error]  ${RESET} $*" > /dev/stderr
  fi
}

info() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_INFO ]]; then
    echo -e "${GREEN}[info] ${RESET} $*" > /dev/stderr
  fi
}

warn() {
  if [[ $LOG_LEVEL -ge $LOG_LEVEL_WARNING ]]; then
    echo -e "${YELLOW}[warning]${RESET} $*" > /dev/stderr
  fi
}

abort() {
  error "$@"
  exit 1
}

have_sudo_access() {
  if [[ ! -x "/usr/bin/sudo" ]]; then
    return 1
  fi

  local -a SUDO=("/usr/bin/sudo")
  if [[ -n "${SUDO_ASKPASS-}" ]]; then
    SUDO+=("-A")
  elif [[ -n "${NONINTERACTIVE-}" ]]; then
    SUDO+=("-n")
  fi

  if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
    if [[ -n "${NONINTERACTIVE-}" ]]; then
      "${SUDO[@]}" -l mkdir &>/dev/null
    else
      "${SUDO[@]}" -v && "${SUDO[@]}" -l mkdir &>/dev/null
    fi
    HAVE_SUDO_ACCESS="$?"
  fi

  if [[ -z "${IS_LINUX-}" ]] && [[ "${HAVE_SUDO_ACCESS}" -ne 0 ]]; then
    abort "Need sudo access on macOS (e.g. the user ${USER} needs to be an Administrator)!"
  fi

  return "${HAVE_SUDO_ACCESS}"
}

shell_join() {
  local arg
  printf "%s" "${1}"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

execute() {
  if [[ ! "$@" ]]; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

execute_sudo() {
  local -a args=("$@")
  if have_sudo_access; then
    if [[ -n "${SUDO_ASKPASS-}" ]]; then
      args=("-A" "${args[@]}")
    fi
    execute "/usr/bin/sudo" "${args[@]}"
  else
    execute "${args[@]}"
  fi
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

bi() {
  if [[ ! $(brew list $1 &>/dev/null) ]]; then
    info " Installing ${1} ..."
    brew install $1
  fi
}



# Check operation system
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
  if [[ ! -f /etc/debian_version ]]; then
    abort "We support only Debian based distributives"
  fi

  IS_LINUX=1

  info "Installing base packages ..."
  execute_sudo apt-get install -y build-essential \
    wget \
    git \
    zsh \
    software-properties-common \
    python3-dev \
    python3-pip

  info "Installing Brew for linux ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

elif [[ "${OS}" != "Darwin" ]]; then
  abort "Not supported OS."
fi

if [[ -n "${ZSH_VERSION}" ]]; then
  info "Make zsh the default shell"
  chsh -s $(which zsh)
fi

if [[ ! -d "${DOTFILES}" ]]; then
  info "Download dotfiles ..."
  git clone https://github.com/akopkesheshyan/dotfiles.git "$DOTFILES" 
fi

info "Setting up local folders ..."
for folder in "Projects" ".config"; do
  if [[ ! -d "${HOME}/${folder}" ]]; then 
    mkdir "${HOME}/${folder}"
  fi
done

install_scripts=($DOTFILES/*/setup.sh)
for file in ${install_scripts}; do
  source $file
done
