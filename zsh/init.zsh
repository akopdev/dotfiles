export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

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
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don' record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line

bindkey '^E' edit-command-line          # ctrl  + e
bindkey '^[[1;2D' backward-word         # shift + left
bindkey '^[[1;2C' forward-word          # shirt + right
bindkey '^[[1;3D' beginning-of-line     # alt   + left
bindkey '^[[1;3C' end-of-line           # alt   + right
# bindkey '^[[3~' delete-char
# bindkey '^?' backward-delete-chart
