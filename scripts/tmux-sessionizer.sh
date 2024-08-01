#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev ~/dev/frontend/apps ~/dev/frontend/packages ~/dev/personal ~/dev/personal/.dotfiles -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

tmux_attached=$(tmux ls | grep attached | awk -F: '{print $1}')

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -n $tmux_attached ]]; then
    tmux switch-client -t $selected_name
else
    tmux attach-session -t $selected_name
fi
