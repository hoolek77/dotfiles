#!/usr/bin/env bash

path_to_strip=/Users/szymonkin/
path_to_config=~/dev/personal/.dotfiles/scripts/scripts-config/tmux-sessionizer

# join each line of config into a string separated by space

find_paths=()

# Read the file line by line, expand tilde, and append each line to the array
while IFS= read -r path; do
    # Check if the path starts with ~
    if [[ $path == "~"* ]]; then
        # Expand ~ to home directory
        expanded_path="$HOME${path:1}"
    else
        expanded_path="$path"
    fi
    paths+=("$expanded_path")
done < "$path_to_config"


if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find "${paths[@]}" -mindepth 1 -maxdepth 1 -type d | sed "s|$path_to_strip||" | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected=$path_to_strip$selected

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

tmux_attached=$(tmux ls | grep attached | awk -F: '{print $1}')

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "No tmux session running"
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "Creating new session"
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -n $tmux_attached ]]; then
    tmux switch-client -t $selected_name
else
    tmux attach-session -t $selected_name
fi
