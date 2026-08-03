# System
alias c="clear"
alias ls="eza --group-directories-first --icons --all"
alias l="eza --group-directories-first --icons --oneline --all"
alias ll="eza --group-directories-first --icons --long --all --git"
alias lt="eza --group-directories-first --icons --tree --all --level=3 --ignore-glob '.git|node_modules|.pytest_cache|__pycache__'"
alias f="find-text"
alias ff="find-file"
case "$(uname)" in
  Darwin) alias poweroff="sudo shutdown -h now" ;;
  Linux) alias poweroff="systemctl poweroff" ;;
esac
case "$(uname)" in
  Darwin) alias reboot="sudo shutdown -r now" ;;
  Linux) alias reboot="systemctl reboot" ;;
esac

# Applications
alias top="htop"
alias wifi="wifitui"
alias files="bash -c fff"
alias xmpp="profanity"
alias irc="irssi"
alias browser="nohup qutebrowser > /dev/null 2>&1 &"

# Neovim
alias vim="nvim"
alias vimdiff='nvim -d'

# Docker
alias dl="docker-logs"
alias de="docker-exec"
alias ds="docker-search"
alias dk="docker kill"
alias dps="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
alias di="docker images -a --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'"
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dr='docker run -it --rm'

# Podman
alias pk="podman kill"
alias pps="podman ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
alias pi="podman images -a --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'"
alias prm='podman rm $(podman ps -aq)'
alias prmi='podman rmi $(podman images -q)'
alias pr='podman run -it --rm'

# Git
alias ga="git add"
alias gaa="git add -A"
alias gap="git add -p"
alias gb="git-branch"
alias gbd="git branch -D"
alias gcam="git add -A && git commit -m"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gf="git fetch"
alias gl="git-log"
alias gp="git push"
alias gpf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gr="git rebase -i"
alias grm="git-rebase-master"
alias gs="git status"
alias gtm="git-time-machine"

# Github
alias ghpr="github-pull-requests"
alias gha="github-actions"

# Kubectl
alias k="kubectl"
alias kg="kubectl get all"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kdp="kubectl describe pods"
alias kds="kubectl describe services"
alias kl="kubectl logs"
alias kc="kubectl config get-contexts --output='name' | fzf | tr -d '[:space:]' | xargs -0 kubectl config use-context"
