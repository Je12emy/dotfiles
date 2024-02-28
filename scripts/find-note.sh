#! /bin/bash

entries=$(find "$HOME/Sync/Notes" -iname "*.md")

choice=$(printf '%s\n' "${entries[@]}" \
        | cut -d '/' -f4- \
        | sort -g \
        | tofi --prompt-text="Note: " --horizontal=false) || exit 1

[[ -n choice ]] || exit

wezterm cli spawn --workspace notes --domain-name local --new-window nvim "$choice"
notify-send "Opened note in wezterm workspace"
