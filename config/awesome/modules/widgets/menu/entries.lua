local tools_menu = {
    { "󰞡 GIMP",
        "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=gimp-2.10 --file-forwarding org.gimp.GIMP @@u  @@" },
    { " Obsidian",
        "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obsidian.sh --file-forwarding md.obsidian.Obsidian @@u  @@" },
    { "󰙅 File Browser",
        "pcmanfm" },
    { " Screenshot",
        "flameshot gui" },
    { "󰛮 Mail/RSS",
        "flatpak run eu.betterbird.Betterbird" },
    { "󱋖 Syncthing",
        "flatpak run me.kozec.syncthingtk" },
}

local internet_menu = {
    { "  Firefox", "/usr/lib/firefox/firefox " },
}

local menu = {
    { "󰖟 Internet", internet_menu },
    { " Tools", tools_menu }
}

return menu
