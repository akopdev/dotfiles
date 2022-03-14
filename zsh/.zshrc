# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.dotfiles
export PROJECTS=$HOME/Projects
export EDITOR=nvim
export GOROOT=$(brew --prefix golang)/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# On linux add PATH to brew 
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load everything but the completion files
for file in ${config_files:#*/completion.zsh}
do
  source $file
done

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
