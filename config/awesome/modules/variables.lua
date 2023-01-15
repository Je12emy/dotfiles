local beautiful = require("beautiful")
-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
    os.getenv("HOME"), "catpuccin")
beautiful.init(theme_path)
