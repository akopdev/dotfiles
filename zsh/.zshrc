# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.dotfiles
export PROJECTS=$HOME/Projects
export GOPATH=$HOME/go
export EDITOR=nvim

# On linux add PATH to brew 
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export GOROOT=$(brew --prefix golang)/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$ZSH/bin

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

# rebind some of keys defined by zsh-vi-mode plugin
# see https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
function zvm_after_init() {
  bindkey -s "^N" 'nvim^M'
  bindkey -s '^P' 'projects^M'
}

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

# fzf global setup
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --border
 --reverse 
 --margin=1  
 --bind='ctrl-n:preview-down,ctrl-p:preview-up'
 --color=fg:#e0def4,hl:#6e6a86
 --color=fg+:#908caa,bg+:#232136,hl+:#908caa
 --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97,border:#e0def4"
