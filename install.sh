#!/bin/bash
set -u

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

USER="akopkesheshyan"
HOME="/home/$USER"

if [[ "$(uname)" == "Linux" ]]
then
  # --------------------------------------------------------------------
  # We assume that docker, k8s, and brew are already installed on MacOS
  # however for linux we should setup everything from scratch
  # --------------------------------------------------------------------


  # Let's create normal user first
  if ! id "$USER" &>/dev/null
  then
    echo "Settings password for $USER:"
    useradd -m "$USER"
    passwd "$USER"
  fi

  # Install essentials
  apt install -y build-essential wget git zsh software-properties-common python-dev python-pip python3-dev python3-pip

  # Make zsh default shell
  su "$USER" -c 'chsh -s $(which zsh)'

  # Install Docker
  if ! command -v docker > /dev/null
  then
    apt install -y apt-transport-https ca-certificates gnupg lsb-release

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update
    apt install -y docker-ce docker-ce-cli containerd.io
  fi

  # Install minikube and k8s tools 
  if ! command minikube > /dev/null
  then
    apt install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager conntrack

    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    mv minikube-linux-amd64 /usr/local/bin/minikube
    chmod +x /usr/local/bin/minikube
  fi

  if ! command kubectl > /dev/null
  then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    mv ./kubectl /usr/local/bin/kubectl
    chmod +x /usr/local/bin/kubectl
  fi

  # If it is a host machine, we should install additional packages
  apt install -y i3 rofi xorg kitty

  # We use brew as our main package manager
  su "$USER" -c '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  su "$USER" -c '/bin/bash -c "eval $('"$HOME"'/.linuxbrew/bin/brew shellenv)"'

  echo 'eval "$('"$HOME"'/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"

fi

DOTFILES="$HOME/.dotfiles"

if [ ! -d "$DOTFILES" ]
then
  git clone https://github.com/akopkesheshyan/dotfiles.git "$DOTFILES" 
fi

# Install dependencies
su "$USER" -c '/bin/bash -c "cd ~ && '"$HOME"'/.linuxbrew/bin/brew  install zsh-autosuggestions zsh-vi-mode bc fzf exa htop bat git-delta ctop neovim nodejs npm"'

# Create project folder used by "p" alias
[ ! -d "$HOME/Projects" ] && mkdir "$HOME/Projects"

# Create symlinks
[ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"

if [ ! -f "$HOME/.zshrc" ]
then
  ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
fi

if [ ! -f "$HOME/.gitconfig" ]
then
  ln -s "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
fi

if [ ! -d "$HOME/.config/nvim" ]
then
  ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"
fi

if [ ! -d "$HOME/.config/kitty" ]
then
  ln -s "$DOTFILES/kitty" "$HOME/.config/kitty"
fi


if [ ! -d "$HOME/.config/bat" ]
then
  ln -s "$DOTFILES/bat" "$HOME/.config/bat"
fi

if [ ! -d "$HOME/.config/ranger" ]
then
  ln -s "$DOTFILES/ranger" "$HOME/.config/ranger"
fi
### Setup additional packages

## neovim

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

