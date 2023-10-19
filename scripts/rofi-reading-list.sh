FILE_PATH=~/.local/share/reading-list.txt
touch ~/.local/share/reading-list.txt

main(){
    status_options=("Todo" "Done" "All")
    status=$(printf "%s\n" "${status_options[@]}" | rofi -dmenu -p "Reading status")
    if [ -n "$status" ];then
        echo $status
        options=""
        case $status in
            "Todo")
                options=$(awk -F ';' '{if ($1 == "Todo") print $2;}' $FILE_PATH)
            ;;
            "Done")
                options=$(awk -F ';' '{if ($1 == "Done") print $2;}' $FILE_PATH)
            ;;
            "All")
                options=$(awk -F ';' '{print $2}' $FILE_PATH)
            ;;
            *)
                options=$(awk -F ';' '{print $2}' $FILE_PATH)
            ;;
        esac
        SELECTION=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "Reading List")
        if [ -n "$SELECTION" ]; then
            source=$(awk -F ";" -v title="$SELECTION" '{if ($2 == title) print $3;}' $FILE_PATH)
            xdg-open "$source"
        fi
    fi
}
main
