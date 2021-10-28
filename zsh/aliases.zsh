alias ..="cd .."
alias ~="cd ~"
alias p="goto-projects"
alias :q="exit"
alias c="clear"
alias l="exa --group-directories-first --icons --oneline --all"
alias ll="exa --group-directories-first --icons --long --all --git"
alias lt="exa --group-directories-first --icons --tree --all --level=3 --ignore-glob '.git|node_modules|.pytest_cache|__pycache__'"
alias f="find"
alias ff="find-file"
alias passgen="passgen"
if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh="kitty +kitten ssh"
fi
