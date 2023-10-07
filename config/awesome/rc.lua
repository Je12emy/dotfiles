-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- awesome's modules
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- widget and layout library
local wibox = require("wibox")
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- My modules
local dbg = require("modules.helpers.debug")
local theming = require("modules.themes.init")
local bar_widget = require("modules.widgets.bar.init")
local variables = require("modules.variables")
local menu_widget = require("modules.widgets.menu.init")
local autostart = require("modules.autostart")
-- Load Debian menu entries
-- local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- Error handling
require("modules.error_handling")

local theme = theming.get_theme(theming.available_themes.catpuccin.name)
beautiful.init(theme)
Modkey = variables.mod_key

-- Enabled layouts
local layouts = require("modules.layouts")
awful.layout.layouts = layouts.enabled

-- Menu
if has_fdo then
	mymainmenu = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})
else
	mymainmenu = awful.menu({
		items = menu_widget.setup(variables),
	})
end

mylauncher = awful.widget.launcher({
	image = beautiful.menu_icon,
	menu = mymainmenu,
})

-- Menubar configuration
menubar.utils.terminal = variables.terminal -- Set the terminal for applications that require it

-- Wibar
awful.screen.connect_for_each_screen(function(current_screen)
	theming.set_wallpaper(current_screen)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, current_screen, awful.layout.layouts[1])
	current_screen.wibox = awful.wibar({ position = "top", screen = current_screen })
	bar_widget.init(current_screen)
	current_screen.wibox:setup(bar_widget.get_bar(current_screen))
end)

-- Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

local map = require("modules.keymaps.map")
local group = require("modules.keymaps.groups")

globalkeys = gears.table.join(

	-- Awesome keybinds
	map.smap("Control", "r", awesome.restart, {
		description = "Reload awesome",
		group = group.key_group.awesome,
	}),
	map.smap("Shift", "q", awesome.quit, { description = "Quit awesome", group = group.key_group.awesome }),
	map.smap(nil, "s", hotkeys_popup.show_help, {
		description = "Show help",
		group = group.key_group_awesome,
	}),
	map.smap(nil, "w", function()
		mymainmenu:show()
	end, {
		description = "Show main menu",
		group = group.key_group_awesome,
	}),

	-- Client Keybinds
	map.smap(nil, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "Focus next by index", group = group.key_group.client }),
	map.smap(nil, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "Focus previous by index", group = group.key_group.client }),
	map.smap("Shift", "j", function()
		awful.client.swap.byidx(1)
	end, { description = "Swap with next client by index", group = group.key_group.client }),
	map.smap("Shift", "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "Swap with previous client by index", group = group.key_group.client }),
	map.smap("Control", "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "Restore minimized", group = group.key_group.client }),
	map.smap(nil, "u", awful.client.urgent.jumpto, {
		description = "Jump to urgent client",
		group = group.key_group.client,
	}),

	-- Apps group
	map.smap(nil, "Return", function()
		awful.spawn(variables.terminal)
	end, { description = "Open a terminal", group = group.key_group.apps }),
	map.nmap(nil, "Print", function()
		awful.util.spawn("flameshot screen")
	end, { description = "Take a screenshot", group = group.key_group.apps }),
	map.smap(nil, "Print", function()
		awful.util.spawn("flameshot gui")
	end, { description = "Open the flameshot gui", group = group.key_group.apps }),

	-- Finder
	map.smap(nil, "p", function()
		awful.keygrabber.run(function(_, key, event)
			if event == "release" then
				return
			end
			if key == " " then
				awful.util.spawn("rofi -show drun")
			elseif key == "Tab" then
				awful.util.spawn("rofi -show window")
			elseif key == "Return" then
				awful.util.spawn("rofi -show run")
			elseif key == "r" then
				awful.util.spawn("/home/jeremy/.local/bin/rofi-pdf.sh")
			elseif key == "p" then
				awful.util.spawn("/home/jeremy/.local/bin/rofi-pass.sh")
			else
				awful.keygrabber.stop()
			end
		end)
	end, { description = "Rofi launchers", group = group.key_group.rofi }),

	-- Layout
	map.smap(nil, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "Increase window width", group = group.key_group.layout }),
	map.smap(nil, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "Decrease window width", group = group.key_group.layout }),
	map.smap("Shift", "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "Increase the number of master clients", group = group.key_group.layout }),
	map.smap("Shift", "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = group.key_group.layout }),
	map.smap("Control", "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "Increase the number of columns", group = group.key_group.layout }),
	map.smap("Control", "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "Decrease the number of columns", group = group.key_group.layout }),
	map.smap(nil, "space", function()
		awful.layout.inc(1)
	end, {
		description = "Select next layout",
		group = group.key_group.layout,
	}),
	map.smap("Shift", "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = group.key_group.layout }),

	-- Tag group
	map.smap("Shift", "Tab", awful.tag.viewprev, { description = "Left tag", group = group.key_group.tag }),
	map.smap(nil, "Tab", awful.tag.viewnext, {
		description = "Right tag",
		group = group.key_group.tag,
	}),
	map.smap(nil, "Escape", awful.tag.history.restore, { description = "Go back", group = group.key_group.tag }),
	-- Screen
	map.smap("Control", "j", function()
		awful.screen.focus_relative(1)
	end, { description = "Focus the next screen", group = group.key_group.screen }),
	map.smap("Control", "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "Focus the previous screen", group = group.key_group.screen })
)

-- Bind all key numbers to tags.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys, -- View tag only.
		map.smap(nil, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "View tag #" .. i, group = group.key_group.tag }),
		-- Toggle tag display.
		map.smap("Control", "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "Toggle tag #" .. i, group = group.key_group.tag }),
		-- Move client to tag.
		map.smap("Shift", "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "Move focused client to tag #" .. i, group = group.key_group.tag }),
		-- Toggle tag on focused client.
		map.smap({ "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = group.key_group.tag })
	)
end

clientkeys = gears.table.join(
	map.smap(nil, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "Toggle fullscreen", group = group.key_group.client }),
	map.smap("Shift", "c", function(c)
		c:kill()
	end, { description = "Close", group = group.key_group.client }),
	map.smap(
		"Control",
		"space",
		awful.client.floating.toggle,
		{ description = "Toggle floating", group = group.key_group.client }
	),
	map.smap("Control", "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "Move to master", group = group.key_group.client }),
	map.smap(nil, "o", function(c)
		c:move_to_screen()
	end, { description = "Move to screen", group = group.key_group.client }),
	map.smap(nil, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "Toggle keep on top", group = group.key_group.client }),
	map.smap(nil, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "Minimize", group = group.key_group.client }),
	map.smap(nil, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(Un)maximize", group = group.key_group.client }),
	map.smap("Control", "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(Un)maximize vertically", group = group.key_group.client }),
	map.smap("Shift", "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(Un)maximize horizontally", group = group.key_group.client })
)

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ Modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ Modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	}, -- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	}, -- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false },
	},
	-- { rule = { class = "firefox" }, properties = { screen = 1, tag = "2" } },
	{ rule = { class = "Spotify" }, properties = { screen = 1, tag = "9" } },
}

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			-- Middle
			{
				-- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

autostart.spawn()
