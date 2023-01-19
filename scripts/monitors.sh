#! /bin/bash
# HDMI-A-0 is my primary monitor
# DisplayPort-2 is my secondary monitor
xrandr \
	--output DisplayPort-2 --mode 1360x768 --rate 60.00 \
	--output HDMI-A-0 --primary --mode 1920x1080 --rate 144.01 --left-of DisplayPort-2 \
