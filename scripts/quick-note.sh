#! /bin/bash
title=$(echo "" | tofi --prompt-text="Title: " --require-match=false)
[[ -n $title ]] || exit

description=$(echo "" | tofi --prompt-text="Note: " --require-match=false)

note_title=$(echo "$title" | sed 's/ /-/g')
note_path="$HOME/Sync/Notes/00-inbox/$note_title.md"

echo "$description" > "$note_path"
notify-send "New note $note_title has been created."
