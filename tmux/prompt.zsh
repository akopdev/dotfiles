#!/usr/bin/env zsh
source ~/.zshrc
echo "#{s|$HOME|~|:#{s|$PROJECTS/||:pane_current_path}}"


