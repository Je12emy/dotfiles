local wibox = require("wibox")

local m = {}

m.standard = function(left, middle, right)
	return {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widget
			layout = wibox.layout.fixed.horizontal,
			table.unpack(left),
		},
		-- Middle widget
		middle,
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			table.unpack(right),
		},
	}
end

-- mac/gnome like
m.gnomed = function(left, middle, right)
	return {
		layout = wibox.layout.stack,
		{
			layout = wibox.layout.align.horizontal,
			{
				-- Left
				layout = wibox.layout.fixed.horizontal,
				spacing = 5,
				table.unpack(left),
			},
			nil,
			{
				-- Right
				layout = wibox.layout.fixed.horizontal,
				spacing = 5,
				table.unpack(right),
			},
		},
		{
			-- Middle
			layout = wibox.container.place,
			table.unpack(middle),
			valign = "center",
			halign = "center",
		},
	}
end

-- Keeping this for future reference
-- Add widgets to the wibox
--  s.mywibox:setup {
--      layout = wibox.layout.align.horizontal,
--      { -- Left widgets
--          layout = wibox.layout.fixed.horizontal,
--          -- mylauncher,
-- wibox.widget.textbox(" "),
--          s.mytaglist,
--      },
--      s.mytasklist, -- Middle widget
--      { -- Right widgets
--          layout = wibox.layout.fixed.horizontal,
-- systray_widget.systray,
-- wibox.widget.textbox(" "),
--          textclock_widget.standard,
-- wibox.widget.textbox(" "),
--          -- mykeyboardlayout,
-- volume_widget({
-- widget_type = "arc",
-- }),
-- net_wired,
-- logout_menu_widget(),
-- wibox.widget.textbox(" "),
--          -- s.mylayoutbox,
--      },
--  }
-- MAC-OS like set-up
-- Add widgets to the wibox
-- s.mywibox:setup({
-- 	layout = wibox.layout.stack,
-- 	{
-- 		layout = wibox.layout.align.horizontal,
-- 		{
-- 			layout = wibox.layout.fixed.horizontal,
-- 			spacing = 5,
-- 			wibox.widget.textbox(" "),
-- 			-- mylauncher,
-- 			s.mytaglist,
-- 			s.mytasklist,
-- 			s.mypromptbox,
-- 		},
-- 		nil,
-- 		{
-- 			layout = wibox.layout.fixed.horizontal,
-- 			spacing = 5,
-- 			my_systray,
-- 			mykeyboardlayout,
-- 			volume_widget({
-- 				widget_type = "arc",
-- 			}),
-- 			-- syncthing_widget.status(),
-- 			net_wired,
-- 			logout_menu_widget(),
-- 			wibox.widget.textbox(" "),
-- 		},
-- 	},
-- 	{
-- 		-- Middle widgets
-- 		layout = wibox.container.place,
-- 		mytextclock,
-- 		valign = "center",
-- 		halign = "center",
-- 	},
-- })

return m
