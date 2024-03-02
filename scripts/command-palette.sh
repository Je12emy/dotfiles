#! /bin/bash
declare -A commands=(\
    ["Open notes"]="open-notes.sh" \ 
    ["Password picker"]="password-picker.sh" \
    ["Find document"]="find-documents.sh" \ 
    ["Take screenshot"]="screenshot.sh" \
    ["Change screen temperature"]="screen-temp.sh" \
    ["Change wallpaper"]="wallpaper-picker.sh" \ 
    ["Exit"]="power-menu.sh")

choice=$(printf "%s\n" "${!commands[@]}" | $MENU --prompt-text="Command Palete: ")

[[ -n $choice ]] || exit

$HOME/.local/bin/${commands[$choice]}
