#!/bin/bash
declare -A commands=(\
    ["Password picker"]="password-picker.sh"\
    ["Pick wallpaper"]="change-wallpaper.sh"\ 
    ["Exit"]="power-menu.sh")

choice=$(printf "%s\n" "${!commands[@]}" | tofi --prompt-text="Command Palete: ")

[[ -n $choice ]] || exit

$HOME/.local/bin/${commands[$choice]}
