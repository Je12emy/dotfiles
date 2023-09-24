local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local systray_widget = require("widgets.systray")
local spacer = require("widgets.spacer")
local topbar = require("widgets.topbar")
local clock = require("widgets.clock")

local m = {}

m.standard = function(screen_taglist, screen_tasklist, screen_layout_box)
	return topbar.standard(
		{
			spacer.normal(),
			screen_taglist,
			spacer.normal(),
		},
		screen_tasklist,
		{
			systray_widget.systray,
			spacer.normal(),
			screen_layout_box,
			clock.standard(),
			spacer.normal(),
			-- mykeyboardlayout,
			volume_widget({
				widget_type = "arc",
			}),
			logout_menu_widget(),
			spacer.normal(),
		}
	)
end

return m
