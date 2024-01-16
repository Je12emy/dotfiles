#/bin/bash
wallpaper=$1
# Set colors with wal
wal -i "$wallpaper"
# Generate zellij colorscheme
$(generate-zellij-theme.sh)
# Append wallpaper to hyprpaper.conf
# read it from .cache/wal
wallpaper_path=$(cat ~/.cache/wal/wal)
hyprpaper_path="$HOME/.config/hypr/hyprpaper.conf"
# Delete the contents hyprpaper and generate a new config file
$(sed -i '2,3s/.*/ /' "$hyprpaper_path")
echo "" > $hyprpaper_path
echo "splash = true" >> $hyprpaper_path
echo "preload = $wallpaper_path" >> $hyprpaper_path
echo "wallpaper = HDMI-A-1, $wallpaper_path" >> $hyprpaper_path
# Reload hyprpaper and waybar
killall waybar
killall hyprpaper
waybar & hyprpaper & disown
