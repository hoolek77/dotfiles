#!/usr/bin/env bash
source ~/dev/personal/.dotfiles/scripts/tmux-sessionizer-config.sh

if [[ $# -eq 1 ]]; then
  selected=$(awk -v prefix="$root_path_prefix" '{sub(prefix, ""); print $0}' <<< $1)
else
    selected=$(
        find "${paths_to_search[@]}" \
          -mindepth 1 \
          -maxdepth 1 \
          -type d \
          | awk -v prefix="$root_path_prefix" '{sub(prefix, ""); print $0}' \
          | fzf
    )
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected="$root_path_prefix$selected"

selected_name=$(echo "$selected" | awk -F'/' '{print $(NF-1)"/"$NF}' | tr '.' '_')
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
