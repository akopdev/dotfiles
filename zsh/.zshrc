# shortcut to this dotfiles path is $ZSH
export ZSH="${HOME}/.dotfiles"
export PROJECTS="${HOME}/Projects"
export GOPATH="${HOME}/go"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
# On linux add PATH to brew 
if ! command -v "brew" &> /dev/null; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -z "$HOMEBREW_PREFIX" ]; then
  HOMEBREW_PREFIX=$(brew --prefix)
fi

export GOROOT="${HOMEBREW_PREFIX}/opt/go/libexec"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$ZSH/bin
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true
export DISPLAY=:0

fpath=($ZSH/bin $fpath)
autoload -U $ZSH/bin/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS 
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS  # don' record dupes in history
setopt APPEND_HISTORY # adds history
setopt SHARE_HISTORY # share history between all terminals
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt AUTOCD # navigate through folders without cd

stty stop undef		# Disable ctrl-s to freeze terminal.


# all of our zsh files
source "${ZSH}/zsh/aliases.zsh"
source "${ZSH}/zsh/prompt.zsh"

# configuring completions
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# Initialize plug-in manager
source "${HOMEBREW_PREFIX}/opt/zinit/zinit.zsh"

# Replace Ctrl-r with an fzf-driven, searchable list of history
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

# A better and friendly vi(vim) mode plugin for ZSH.
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# rebind some of keys defined by zsh-vi-mode plugin
function zvm_after_init() {
  bindkey -s "^N" 'nvim^M'
  bindkey -s '^P' 'projects^M'
  bindkey -s '^F' 'find-text^M'
  bindkey -s '^E' 'ranger^M'
}

function zvm_after_lazy_keybindings() {
  zvm_bindkey vicmd 'H' vi-backward-word
  zvm_bindkey vicmd 'L' vi-forward-word
  zvm_bindkey vicmd '^H' vi-first-non-blank
  zvm_bindkey vicmd '^L' vi-end-of-line
}

zvm_before_init() {
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)

  ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#eb6f92\a'
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#eb6f92\a'
}
# Replace zsh's default completion selection menu with fzf!
zinit light Aloxaf/fzf-tab

# Fish-like fast/unobtrusive autosuggestions for zsh.
zinit load zsh-users/zsh-autosuggestions

# fzf global setup
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*" --ignore-file ~/dotfiles/fzf-ignore'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --border
 --reverse 
 --margin=1  
 --preview-window='up,80%,border-bottom' 
 --bind='ctrl-f:preview-down,ctrl-b:preview-up'
 --bind='ctrl-p:toggle-preview'
 --color=fg:#e0def4,hl:#6e6a86
 --color=fg+:#908caa,bg+:#232136,hl+:#908caa
 --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97,border:#e0def4"

