#!/bin/bash

declare -A screen_temperature_profiles=( ["Day"]=6500 ["Night"]=3800 )

choice=$(printf "%s\n" "${!screen_temperature_profiles[@]}"  | tofi --prompt-text="Color Profiles" --horizontal=false)

case "$choice" in
	"Day")
		$(busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q "${screen_temperature_profiles["Day"]}")
		;;
	"Night")
		$(busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q "${screen_temperature_profiles["Night"]}")
		;;
	*)
		$(busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q "${screen_temperature_profiles["Day"]}")
		;;
esac
