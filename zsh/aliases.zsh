# System
alias c="clear"
alias ls="exa --group-directories-first --icons --all"
alias l="exa --group-directories-first --icons --oneline --all"
alias ll="exa --group-directories-first --icons --long --all --git"
alias lt="exa --group-directories-first --icons --tree --all --level=3 --ignore-glob '.git|node_modules|.pytest_cache|__pycache__'"
alias f="find-text"
alias ff="find-file"
alias top="htop"

# Neovim
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'

# Docker
alias d="docker"
alias dl="docker-logs"
alias de="docker-exec"
alias ds="docker-search"
alias dk="docker kill"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"

# Git
alias ga="git add"
alias gap="git add -p"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gcam="git add -A && git commit -m"
alias gs="git status"
alias gp="git push"
alias gpf="git push --force"
alias gpl="git pull"
alias gf="git fetch"
alias gl="git-log"
alias gd="git diff"
alias gb="git-branch"
alias gcb="git checkout -b"
alias grm="git-rebase-master"
alias gr="git rebase -i"

# Kubectl
alias k="kubectl"
alias kg="kubectl get all"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kdp="kubectl describe pods"
alias kds="kubectl describe services"
alias kl="kubectl logs"
