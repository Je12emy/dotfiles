local wibox = require("wibox")

-- NOTE when importing this module,
-- the widgets are initialized so the placement of the initialization is important
local m = {}
-- Wed Jul 19 12:46 pm
m.standard = function()
	return wibox.widget.textclock("%a %d %b, %I:%M %p")
end
-- 2023/07/19 12:48 pm
m.short = function()
	return wibox.widget.textclock("%Y/%m/%d %H:%M %p")
end

return m
