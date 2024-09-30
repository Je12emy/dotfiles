#! /bin/bash
# A script to read the available wallpapers and change them in hyprpaper

# Get options
wallpapers_dir="$HOME/Pictures/wallpapers"
options=$(ls $wallpapers_dir)
wallpaper=$(printf "%s\n" ${options[@]} | tofi --prompt-text="Wallpaper: ")

# Pick a wallpaper
[[ -n $wallpaper ]] || exit

# Locate config file
hypr_base="$HOME/.config/hypr"
hyprpaper_config="$hypr_base/hyprpaper.conf"
hyprlock_config="$hypr_base/hyprlock.conf"

wallpaper_path="$wallpapers_dir/$wallpaper"


# Replace the config variables in hyprpaper
sed -i '/wallpaper =/c\wallpaper = ,'"$wallpaper_path"'' $hyprpaper_config
sed -i '/preload =/c\preload = '"$wallpaper_path"'' $hyprpaper_config

# Replace the wallpaper variable in hyprlock
sed -i '/path =/c\path = '"$wallpaper_path"'' $hyprlock_config

# Fortune outputs a quote, if available set the lock message
if command -v fortune >&2; then
	greet=$(fortune -s -a)
	sed -i '/text =/c\text = '"$greet"'' $hyprlock_config
fi

# Restart hyprpaper
killall hyprpaper
hyprpaper  & disown
