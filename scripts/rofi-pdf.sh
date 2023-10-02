#! /bin/bash
tmp_file="/tmp/pdf-search"
search_paths="$HOME/LifeOS $HOME/Documents $HOME/Downloads"

find $search_paths -type f -name "*.pdf" | sort | uniq >> $tmp_file
# Check if any PDFs were found
if [ ! -s "$tmp_file" ]; then
    echo "No PDFs found."
    exit 1
fi
selected=$(awk -F '/' '{print $NF}' $tmp_file | rofi -dmenu -p " PDF" -i -markup-rows)
# Check if any PDF was selected
if [ -z "$selected" ]; then
    echo "No file selected."
    exit 1
fi
cat $tmp_file | grep "$selected" | xargs -I {} zathura {}
truncate -s 0 $tmp_file

# The original
# #! /bin/bash
# find ~/ -type f -name "*.pdf" | rofi -dmenu -p " PDF" -i -markup-rows | xargs -I {} zathura {}
