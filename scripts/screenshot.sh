#! /bin/bash
# A simple tofi script to take a screenshot with grimshot

get_output() {
	output=$(printf "%s\n" \
	"Save" \
	"Copy" \
	"Edit" \
	| tofi --prompt="Output: ")

	case $output in
		"Save")
			output="save"
			;;
		"Copy")
			output="copy"
			;;
		"Edit")
			output="edit"
			;;
		*)
			output="copy"
			;;
	esac
}

take_screenshot() {
	case "$1" in
		"screen")
			$(grimshot --notify --wait 1000 $1 $2 | xargs feh)
		;;
		"edit")
			$(grimshot --notify "save" $2 | xargs gimp)
		;;
		*)
			$(grimshot --notify $1 $2 | xargs feh)
		;;
	esac
	return 0
}

source=$(printf '%s\n' \
	"Full Screen" \
	"Area" \
	| tofi --horizontal=false --prompt="Source: ")

get_output

case "$source" in
	"Full Screen")
		take_screenshot "$output" "screen"
	;;
	"Area")
		take_screenshot "$output" "area"
	;;
	*)
		take_screenshot "$output" "area"
	;;
esac
