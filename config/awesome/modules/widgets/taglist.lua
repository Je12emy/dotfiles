local awful = require("awful")
local gears = require("gears")

local m = {}

-- Actions for pressing a button in the taglist
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ Modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ Modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

-- The standard taglist
m.get_standard_taglist = function(screen)
	local tag_list = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.noempty,
		buttons = taglist_buttons,
	})
	return tag_list
end

-- A taglist which displays icons for each tag
m.get_icon_taglist = function(screen, client)
	-- Icons
	local unfocus_icon = " "
	local unfocus_color = "#a6adc8"

	local empty_icon = " "
	local empty_color = "#585b70"

	local focus_icon = " "
	local focus_color = "#89b4fa"

	-- Function to update the tags
	local update_tags = function(self, c3)
		local tagicon = self:get_children_by_id("icon_role")[1]
		if c3.selected then
			tagicon.text = focus_icon
			self.fg = focus_color
		elseif #c3:clients() == 0 then
			tagicon.text = empty_icon
			self.fg = empty_color
		else
			tagicon.text = unfocus_icon
			self.fg = unfocus_color
		end
	end

	local icon_taglist = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		layout = { spacing = 0, layout = wibox.layout.fixed.horizontal },
		widget_template = {
			{
				{
					id = "icon_role",
					font = "FuraMono Nerd Font 12",
					widget = wibox.widget.textbox,
				},
				id = "margin_role",
				top = 0,
				bottom = 0,
				left = 2,
				right = 2,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, c3, index, objects)
				update_tags(self, c3)
			end,

			update_callback = function(self, c3, index, objects)
				update_tags(self, c3)
			end,
		},
		buttons = taglist_buttons,
	})

	return icon_taglist
end

return m
