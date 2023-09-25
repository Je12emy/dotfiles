 local menu98edb85b00d9527ad5acebe451b3fae6 = {
     {"Calculator", "gnome-calculator"},
     {"Characters", "/usr/bin/gnome-characters"},
     {"Clocks", "gnome-clocks"},
     {"Connections", "gnome-connections "},
     {"Disks", "gnome-disks"},
     {"Files", "nautilus --new-window "},
     {"Fonts", "gnome-font-viewer "},
     {"Maps", "gapplication launch org.gnome.Maps "},
     {"Neovim", "xterm -e nvim ", "/usr/share//icons/hicolor/128x128/apps/nvim.png" },
     {"Pika Backup", "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=pika-backup org.gnome.World.PikaBackup"},
     {"Text Editor", "gnome-text-editor "},
     {"Weather", "gapplication launch org.gnome.Weather"},
     {"picom", "picom"},
 }

 local menud334dfcea59127bedfcdbe0a3ee7f494 = {
     {"Document Scanner", "simple-scan"},
     {"Document Viewer", "evince "},
     {"GNU Image Manipulation Program", "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=gimp-2.10 --file-forwarding org.gimp.GIMP @@u  @@", "/var/lib/flatpak/exports/share/icons/hicolor/16x16/apps/org.gimp.GIMP.png" },
     {"Image Viewer", "eog "},
 }

 local menuc8205c7636e728d448c2774e6a4a944b = {
     {"Avahi SSH Server Browser", "/usr/bin/bssh"},
     {"Avahi VNC Server Browser", "/usr/bin/bvnc"},
     {"Connections", "gnome-connections "},
     {"Firefox Web Browser", "/usr/lib/firefox/firefox ", "/usr/share//icons/hicolor/16x16/apps/firefox.png" },
     {"Web", "epiphany "},
 }

 local menudf814135652a5a308fea15bff37ea284 = {
     {"Calendar", "gnome-calendar "},
     {"Contacts", "gnome-contacts"},
     {"Document Viewer", "evince "},
     {"Obsidian", "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obsidian.sh --file-forwarding md.obsidian.Obsidian @@u  @@"},
 }

 local menu52dd1c847264a75f400961bfb4d1c849 = {
     {"Cheese", "cheese"},
     {"Music", "gnome-music"},
     {"Qt V4L2 test Utility", "qv4l2", "/usr/share//icons/hicolor/16x16/apps/qv4l2.png" },
     {"Qt V4L2 video capture utility", "qvidcap", "/usr/share//icons/hicolor/16x16/apps/qvidcap.png" },
     {"Videos", "totem "},
 }

 local menuee69799670a33f75d45c57d1d1cd0ab3 = {
     {"Avahi Zeroconf Browser", "/usr/bin/avahi-discover"},
     {"Color Profile Viewer", "gcm-viewer", "/usr/share//icons/hicolor/16x16/apps/gnome-color-manager.png" },
     {"Console", "kgx"},
     {"Disk Usage Analyzer", "baobab "},
     {"Hardware Locality lstopo", "lstopo"},
     {"Logs", "gnome-logs"},
     {"Parental Controls", "malcontent-control"},
     {"Software", "gnome-software "},
     {"System Monitor", "gnome-system-monitor"},
     {"kitty", "kitty", "/usr/share//icons/hicolor/256x256/apps/kitty.png" },
 }

xdgmenu = {
    {"Accessories", menu98edb85b00d9527ad5acebe451b3fae6},
    {"Graphics", menud334dfcea59127bedfcdbe0a3ee7f494},
    {"Internet", menuc8205c7636e728d448c2774e6a4a944b},
    {"Office", menudf814135652a5a308fea15bff37ea284},
    {"Sound & Video", menu52dd1c847264a75f400961bfb4d1c849},
    {"System Tools", menuee69799670a33f75d45c57d1d1cd0ab3},
}

