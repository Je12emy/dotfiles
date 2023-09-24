local wibox = require("wibox")

local m = {}

m.margin = function(top, right, bottom, left)
	return wibox.widget {
		{
			text = "",
			widget = wibox.widget.textbox
		},
		top = top,
		right = right,
		bottom = bottom,
		left = left,
		layout = wibox.container.margin
	}
end

m.normal = function()
    return wibox.widget{
        text = " ",
        widget = wibox.widget.textbox
    }
end

return m
