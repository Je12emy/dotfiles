local awful = require("awful")
local gears = require("gears")
local m = {}

m.smap = function(plus, key, callback, options)
	if type(plus) == "table" then
		 return awful.key(gears.table.join({ Modkey }, plus), key, callback, options)
	end
	 return awful.key({ Modkey, plus }, key, callback, options)
end

m.nmap = function(plus, key, callback, options)
	return awful.key(gears.table.join(plus), key, callback, options)
end

return m
