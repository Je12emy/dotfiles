#! /bin/bash
case $TERMINAL in
        "wezterm")
                $TERMINAL -e $EDITOR $NOTES_DIR
                ;;
        *)
                $TERMINAL $EDITOR $NOTES_DIR
                ;;
esac
notify-send "Opened notes in $TERMINAL"
