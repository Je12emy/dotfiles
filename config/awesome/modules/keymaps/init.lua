local table = require("gears.table")
local keys = require("modules.keymaps.keys")
local awful = require("awful")

local m = {}

m.global_keys = table.join(
	keys.get_awesome_keys(),
	keys.get_rofi_keys(),
	keys.get_client_keys(),
	keys.get_layout_keys(),
	keys.get_tag_keys(),
	keys.get_program_keys(),
	-- Some stubbord ones which I haven't gotten to work
	awful.key({ Modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ Modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ Modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" })
)

return m
