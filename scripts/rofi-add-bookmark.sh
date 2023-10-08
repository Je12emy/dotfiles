BOOKMARKS_FILE=~/.local/share/bookmarks.txt
touch ~/.local/share/bookmarks.txt

bookmark=$(rofi -dmenu -p "Enter an URL")
if [ -n "$bookmark" ]; then
	annotation=$(rofi -dmenu -p "(Optional) Enter an annotation")
	if [ -n "$annotation" ]; then
		echo "$bookmark #$annotation" >> $BOOKMARKS_FILE
	fi
	echo "$bookmark" >> $BOOKMARKS_FILE
fi
