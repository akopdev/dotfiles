#!/bin/bash
set -u

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

USER="akopkesheshyan"
HOME="/home/$USER"

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  # --------------------------------------------------------------------
  # We assume that docker, k8s, and brew are already installed on MacOS
  # however for linux we should setup everything from scratch
  # --------------------------------------------------------------------


  # Let's create normal user first
  echo "Settings password for $USER:"
  useradd -m "$USER"
  passwd "$USER"

  # Install essentials
  apt install -y build-essential wget git zsh software-properties-common python-dev python-pip python3-dev python3-pip

  # Install Docker
  apt install -y apt-transport-https ca-certificates gnupg lsb-release

  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt update
  apt install -y docker-ce docker-ce-cli containerd.io

  # Install minikube and k8s tools 
  apt install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager conntrack

  wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  mv minikube-linux-amd64 /usr/local/bin/minikube
  chmod +x /usr/local/bin/minikube

  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  mv ./kubectl /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl

  # If it is a host machine, we should install additional packages
  apt install -y i3 rofi xorg kitty

  # We use brew as our main package manager
  su "$USER" -c '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

  export PATH="$HOME/.linuxbrew/bin:$PATH"

fi

DOTFILES="$HOME/.dotfiles"

git clone https://github.com/akopkesheshyan/dotfiles.git "$DOTFILES" 

# Install dependencies
su "$USER" -c "brew install zsh-autosuggestions bc fzf exa ctop neovim nodejs npm"

# Create symlinks
mkdir "$HOME/.config"

ln -s "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"
ln -s "$DOTFILES/kitty" "$HOME/.config/kitty"

