local awful          = require("awful")
local wibox          = require("wibox")
local debug          = require "helpers.debug"
local gears          = require "gears.debug"

local M              = {}

local GET_STATUS_CMD =
[[syncthing cli show system | grep -E 'guiAddressUsed|uptime' | sed 's/,$//']]

local function syncthing_system_status()
    local handle = io.popen(GET_STATUS_CMD)
    local result = handle:read("*a")
    handle:close()
    local data = {}
    for line in result:gmatch("[^\r\n]+") do
        local key, value = line:match('"%s*([^"]+)"%s*:%s*([^,]+)')
        if key and value then
            data[key] = value
        end
    end
    return data
end

local function get_widget()
    local status = syncthing_system_status()
    return wibox.widget {
        {
            text          = status ~= "" and "" or "",
            align         = 'center',
            valign        = 'center',
            forced_height = 30,
            forced_width  = 28,
            font          = "JetBrainsMono Nerd Font 16",
            widget        = wibox.widget.textbox
        },
        top = 0,
        bottom = 0,
        left = 0,
        right = 0,
        widget = wibox.container.margin
    }
end


M.status = function()
    local sync_status = get_widget()
    local sync_status_tooltip = awful.tooltip {
        mode = 'outside',
        preferred_positions = { 'bottom' },
        margins_leftright = 8,
        margins_topbottom = 4
    }
    sync_status_tooltip:add_to_object(sync_status)
    sync_status:connect_signal('mouse::enter', function()
        local data = syncthing_system_status()
        sync_status_tooltip.text = "Uptime: " .. data.uptime .. "\nAddress: " .. data.guiAddressUsed
    end)

    return sync_status
end

return M
