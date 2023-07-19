local wibox = require("wibox")

local m = {}

-- Wed Jul 19 12:46 pm
m.standard = wibox.widget.textclock("%a %d %b, %I:%M %p")
-- 2023/07/19 12:48 pm
m.short = wibox.widget.textclock("%Y/%m/%d %H:%M %p")

return m
