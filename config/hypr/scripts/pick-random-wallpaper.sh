#! /bin/bash
# Picks a random wallpaper and set it using hyprctl

# Pick a random wallpaper
wallpaper_dir="$HOME/Pictures/wallpapers"
wallpaper=$(ls $wallpaper_dir/*.png | shuf -n 1)
echo $wallpaper_path
target_file="$HOME/wallpaper.png"

# Create a symlink to the wallpaper, if it exists, remove it
if [ -f "$target_file" ]; then
	echo "Removing old symlink"
	rm "$target_file"
fi
ln -s "$wallpaper" "$target_file"

# Set the wallpaper at runtime by using hyprctl
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper ",$wallpaper"
