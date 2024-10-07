#! /bin/bash
# Picks a random wallpaper and set it using hyprctl
wallpaper_dir="$HOME/Pictures/wallpapers"
wallpaper=$(ls $wallpaper_dir | shuf -n 1)
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper ",$wallpaper"
