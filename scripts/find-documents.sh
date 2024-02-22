#! /bin/bash

files="$(find "$HOME" -maxdepth 4 -iname "*.pdf")"

choice=$(printf '%s\n' "${files[@]}" \
        | cut -d '/' -f4- \
        | sort -g \
        | tofi --prompt-text="File: " --horizontal=false) || exit 1

if [ "$choice" ]; then
        "zathura" "~/${choice}"
    else
        echo "Program Terminated." && exit 0
fi
