#! /bin/bash

files="$(find "$HOME" -maxdepth 4 -iname "*.pdf")"

choice=$(printf '%s\n' "${files[@]}" \
        | cut -d '/' -f4- \
        | sort -g \
        | tofi --prompt-text="Open file: " --horizontal=false) || exit 1

if [ "$choice" ]; then
    $PDF_VIEWER "$HOME/${choice}"
    notify-send "Opened $choice"
fi
