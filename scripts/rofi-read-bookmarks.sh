BOOKMARKS_FILE=~/.local/share/bookmarks.txt
touch ~/.local/share/bookmarks.txt

bookmark=$(cat $BOOKMARKS_FILE | rofi -dmenu -p "Bookmarks >")

if [ -n "$bookmark" ]; then
	url=$(echo $bookmark | awk '{print $1}')
	xdotool type $url
fi
