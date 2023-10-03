local gears = require("gears")
local awful = require("awful")
local table = gears.table
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")
local variables = require("modules.variables")
local map = require("modules.keymaps.map")

local m = {}

m.get_tag_keys = function()
	local group_name = "Tag 󱂬 "
	local tag_keys = table.join(
		map.smap("Shift", "Tab", awful.tag.viewprev, { description = "Left tag", group = group_name }),
		map.smap(nil, "Tab", awful.tag.viewnext, {
			description = "Right tag",
			group = group_name,
		})
	)
	for i = 1, 9 do
		tag_keys = table.join(
			tag_keys,
			-- View tag only.
			map.smap(nil, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end, { description = "view tag #" .. i, group = group_name }),
			-- Toggle tag display.
			map.smap("Control", "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end, { description = "Toggle tag #" .. i, group = group_name }),
			-- Move client to tag.
			map.smap("Shift", "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end, { description = "Move focused client to tag #" .. i, group = group_name }),
			map.smap({ "Control", "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end, { description = "Toggle focused client on tag #" .. i, group = group_name })
		)
	end
	return table.join(tag_keys, tag_keys)
end

m.get_layout_keys = function()
	local group_name = "Layout 󱗼 "
	return table.join(
		map.smap(nil, "l", function()
			awful.tag.incmwfact(0.05)
		end, { description = "Increase window width", group = group_name }),
		map.smap(nil, "h", function()
			awful.tag.incmwfact(-0.05)
		end, { description = "Decrease window width", group = group_name }),
		map.smap("Shift", "h", function()
			awful.tag.incnmaster(1, nil, true)
		end, { description = "Increase the number of master clients", group = group_name }),
		map.smap("Shift", "l", function()
			awful.tag.incnmaster(-1, nil, true)
		end, { description = "decrease the number of master clients", group = group_name }),
		map.smap("Control", "h", function()
			awful.tag.incncol(1, nil, true)
		end, { description = "Increase the number of columns", group = group_name }),
		map.smap("Control", "l", function()
			awful.tag.incncol(-1, nil, true)
		end, { description = "Decrease the number of columns", group = group_name }),
		map.smap(nil, "space", function()
			awful.layout.inc(1)
		end, {
			description = "Select next layout",
			group = group_name,
		}),
		map.smap("Shift", "space", function()
			awful.layout.inc(-1)
		end, { description = "select previous", group = group_name })
	)
end

m.get_awesome_keys = function()
	local group_name = "Awesome 󰌽 "
	return table.join(
		map.smap("Control", "r", awesome.restart, {
			description = "Reload awesome",
			group = group_name,
		}),
		map.smap("Shift", "q", awesome.quit, { description = "Quit awesome", group = group_name }),
		-- This one isn't working, not sure why
		-- map.smap(nil, "s", hotkeys_popup.show_help, {
		-- 	description = "Show help",
		-- 	group = group_name,
		-- }),
		map.smap(nil, "w", function()
			mymainmenu:show()
		end, {
			description = "Show main menu",
			group = group_name,
		})
	)
end

m.get_client_keys = function()
	local group_name = "Client  "
	return table.join(
		map.smap(nil, "j", function()
			awful.client.focus.byidx(1)
		end, { description = "Focus next by index", group = group_name }),
		map.smap(nil, "k", function()
			awful.client.focus.byidx(-1)
		end, { description = "Focus previous by index", group = group_name }),
		map.smap("Shift", "j", function()
			awful.client.swap.byidx(1)
		end, { description = "Swap with next client by index", group = group_name }),
		map.smap("Shift", "k", function()
			awful.client.swap.byidx(-1)
		end, { description = "Swap with previous client by index", group = group_name }),
		map.smap("Control", "n", function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end, { description = "Restore minimized", group = group_name }),
		map.smap(nil, "u", awful.client.urgent.jumpto, {
			description = "Jump to urgent client",
			group = group_name,
		})
	)
end

m.get_program_keys = function()
	local group_name = "Apps  "
	return table.join(
		map.smap(nil, "Return", function()
			awful.spawn(variables.terminal)
		end, { description = "Open a terminal", group = group_name }),
		map.nmap(nil, "Print", function()
			awful.util.spawn("flameshot screen")
		end, { description = "Take a screenshot", group = group_name }),
		map.smap(nil, "Print", function()
			awful.util.spawn("flameshot gui")
		end, { description = "Open the flameshot gui", group = group_name })
	)
end

m.get_rofi_keys = function()
	local group_name = "Rofi scripts"
	return table.join(map.smap(nil, "p", function()
		awful.keygrabber.run(function(mods, key, event)
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
	end, { description = "Rofi launchers", group = group_name }))
end

return m
