local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local systray = require("widgets.systray")
local spacer = require("widgets.spacer")
local clock = require("widgets.clock")
local bar_template = require("widgets.bar.templates")

local m = {}

m.standard_bar = function(screen_taglist, screen_tasklist, screen_layout_box)
	return bar_template.standard(
		{
			spacer.normal(),
			screen_taglist,
			spacer.normal(),
		},
		screen_tasklist,
		{
			systray.systray,
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
