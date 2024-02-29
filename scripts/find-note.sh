#! /bin/bash

entries=$(find $NOTES_DIR -iname "*.md")

choice=$(printf '%s\n' "${entries[@]}" \
        | cut -d '/' -f4- \
        | sort -g \
        | $MENU --prompt-text="Note: " --horizontal=false) || exit 1

[[ -n $choice ]] || exit

if [[ $TERMINAL == "wezterm" ]];then
        # Non zero code is returned if there are not clients
        wezterm cli list-clients
        if [[ $? -eq 0 ]]; then
                wezterm cli spawn --domain-name local $EDITOR $choice
                # When I specify a workspace, a new instance is launched
                # wezterm cli spawn --workspace notes --domain-name local --new-window nvim "$choice"
                notify-send "Opened note $EDITOR"
        fi
else
        $TERMINAL $EDITOR $choice
        notify-send "Opened note $EDITOR"
fi
