local wibox = require("wibox")

local m = {}

m.systray = wibox.widget({
	{
		{
			wibox.widget.systray(),
			top = 4,
			bottom = 4,
			right = 4,
			left = 4,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
	},
	left = 3,
	widget = wibox.container.margin,
})

return m
