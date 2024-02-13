#/bin/bash
wallpaper=$1
# Set colors with wal
wal -i "$wallpaper"

cache_path="$HOME/.cache/wal"
config_dir_path="$HOME/.config"

# Copy themes
cp "$cache_path/hyprpaper.conf" "$config_dir_path/hypr" 
cp "$cache_path/pywal.kdl" "$config_dir_path/zellij" 
cp "$cache_path/colors.lua" "$config_dir_path/wezterm" 
cp "$cache_path/modules.jsonc" "$config_dir_path/waybar" 

# Reload hyprpaper and waybar
killall waybar
killall hyprpaper
waybar & hyprpaper & disown
