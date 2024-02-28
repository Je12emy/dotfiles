#/bin/bash
cache_path="$HOME/.cache/wal"
config_dir_path="$HOME/.config"

options=$(ls "$HOME/Pictures/wallpapers")
wallpaper=$(printf "%s\n" ${options[@]} | tofi --prompt-text="Wallpaper: ")

[[ -n $wallpaper ]] || exit
# Set colors with wal
wal -i "$wallpaper"
# Copy themes
cp "$cache_path/hyprpaper.conf" "$config_dir_path/hypr" 
cp "$cache_path/pywal.kdl" "$config_dir_path/zellij" 
cp "$cache_path/colors.lua" "$config_dir_path/wezterm" 
cp "$cache_path/modules.jsonc" "$config_dir_path/waybar" 
cp "$cache_path/dunstrc" "$config_dir_path/dunst" 

# Reload modules
killall waybar
killall hyprpaper
killall dunst

waybar & hyprpaper & dunst & disown


notify-send "Wallpaper $wallpaper has been changed"
