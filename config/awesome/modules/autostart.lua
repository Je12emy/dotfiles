local awful = require("awful")

local m = {}

local programs = {
	"setxkbmap latam",
	"picom",
	"xclip",
	"flatpak run --command=pika-backup-monitor org.gnome.World.PikaBackup"
}

m.spawn = function()
	for _, program in ipairs(programs) do
		awful.spawn.with_shell(program)
	end
end

-- awful.spawn.with_shell("/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &")
-- awful.spawn.with_shell("xclip")
-- awful.spawn.with_shell("flatpak run --command=pika-backup-monitor org.gnome.World.PikaBackup")
-- awful.spawn.with_shell("setxkbmap latam")
-- awful.spawn.with_shell("picom")

return m

