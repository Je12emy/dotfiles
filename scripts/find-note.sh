#! /bin/bash

entries=$(find "$HOME/Sync/Notes" -iname "*.md")

choice=$(printf '%s\n' "${entries[@]}" \
        | cut -d '/' -f4- \
        | sort -g \
        | tofi --prompt-text="Note: " --horizontal=false) || exit 1

[[ -n choice ]] || exit

# When I specify a workspace, a new instance is launched
# wezterm cli spawn --workspace notes --domain-name local --new-window nvim "$choice"
wezterm cli spawn --domain-name local nvim "$choice"
notify-send "Opened note in wezterm workspace"
