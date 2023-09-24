local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local m = {}

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local get_tasklist_layout = function(layout)
	local layout_template = {
		spacing = 0,
		-- spacing_widget = {
		-- 	{
		-- 		forced_width = 5,
		-- 		shape = gears.shape.circle,
		-- 		widget = wibox.widget.separator,
		-- 	},
		-- 	valign = "center",
		-- 	halign = "center",
		-- 	widget = wibox.container.place,
		-- },
		layout = layout,
	}
	return layout_template
end

local tasklist_widget_template = {
	{
		{
			-- {
			-- 	{
			-- 		id = "icon_role",
			-- 		widget = wibox.widget.imagebox,
			-- 		forced_height = 26,
			-- 		forced_width = 26,
			-- 		resize = true
			-- 	},
			-- 	margins = 2,
			-- 	widget = wibox.container.margin,
			-- },
			{
				id = "text_role",
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		left = 10,
		right = 10,
		widget = wibox.container.margin,
	},
	id = "background_role",
	widget = wibox.container.background,
}

-- Items take as much space as needed
m.standard_tasklist = function(screen)
	local tasklist = awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = get_tasklist_layout(wibox.layout.flex.horizontal),
		widget_template = tasklist_widget_template,
	})

	return tasklist
end

-- A variation of the standard tasklist but items have a fixed length
m.constrained_tasklist = function(screen)
	local tasklist = awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = get_tasklist_layout(wibox.layout.fixed.horizontal),
		widget_template = tasklist_widget_template,
	})

	return tasklist
end

return m
