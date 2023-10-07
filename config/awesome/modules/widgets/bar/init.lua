-- Awesome
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
-- External Widgets
local volume_widget = require("awesome-wm-widgets.pactl-widget.volume")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
-- My widgets
local bar_template = require("modules.widgets.bar.templates")
local clock_widget = require("modules.widgets.clock")
local systray_widget = require("modules.widgets.systray")
local taglist_widget = require("modules.widgets.taglist")
local tasklist_widget = require("modules.widgets.tasklist")

local m = {}

-- Mutate the screen table with all the wanted widgets
m.init = function(screen)
	screen.layoutbox = awful.widget.layoutbox(screen)
	screen.layoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	screen.layoutbox = awful.widget.layoutbox(screen)
	screen.layoutbox = wibox.container.margin(screen.layoutbox, 5, 5, 5, 5)

	screen.taglist = taglist_widget.get_standard_taglist(screen)
	screen.tasklist = tasklist_widget.constrained_tasklist(screen)

	screen.layoutlist = wibox.widget {
		awful.widget.layoutlist {
			screen      = screen,
			base_layout = wibox.layout.flex.vertical
		},

		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
		widget = wibox.container.margin,
	}
end

-- Setup a bar
m.get_bar = function(screen)
	local left_widgets = {
		wibox.widget {
			{
				screen.taglist,
				left = 5,
				right = 0,
				widget = wibox.container.margin,
			},
			layout = wibox.layout.fixed.horizontal
		}
	}
	local right_widgets = {
		wibox.widget {
			-- screen.layoutlist,
			systray_widget.systray,
			clock_widget.standard(),
			volume_widget({
				widget_type = "arc",
			}),
			logout_menu_widget(),
			spacing = 5,
			layout = wibox.layout.fixed.horizontal
		}
	}
	return bar_template.standard(
		left_widgets,
		screen.tasklist,
		right_widgets
	)
end

m.top_bar = function(screen)
	local left_widgets = {
		wibox.widget {
			{
				screen.taglist,
				left = 5,
				right = 0,
				widget = wibox.container.margin,
			},
			layout = wibox.layout.fixed.horizontal
		}
	}
	local right_widgets = {
		wibox.widget {
			-- screen.layoutlist,
			systray_widget.systray,
			clock_widget.standard(),
			volume_widget({
				widget_type = "arc",
			}),
			logout_menu_widget(),
			spacing = 5,
			layout = wibox.layout.fixed.horizontal
		}
	}
	return bar_template.standard(
		left_widgets,
		systray_widget.systray,
		right_widgets
	)
end

m.bottom_bar = function(screen)
	return bar_template.standard(
		{},
		screen.tasklist,
		{}
	)
end

return m
