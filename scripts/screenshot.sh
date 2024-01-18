#! /bin/bash
# A simple tofi script to take a screenshot with grimshot

get_output() {
	destination=$(printf "%s\n" \
	"Save" \
	"Copy" \
	| tofi --prompt="Output: ")

	case $destination in
		"Save")
			destination="save"
			;;
		"Copy")
			destination="copy"
			;;
		*)
			destination="copy"
			;;
	esac
}

take_screenshot() {
	grimshot --notify --wait 1000 $1 $2 | xargs feh
}

source=$(printf '%s\n' \
	"Full Screen Capture" \
	"Area Capture" \
	| tofi --horizontal=false --prompt="Screenshot: ")

get_output

case "$source" in
	"Full Screen Capture")
		take_screenshot "$destination"  "screen"
	;;
	"Area Capture")
		take_screenshot "$destination" "area"
	;;
	*)
		take_screenshot "$destination" "area"
	;;
esac
