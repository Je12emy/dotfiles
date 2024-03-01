local wezterm = require("wezterm")
local colors = require("colors")

local M = {}

M.set_status_right = function()
  wezterm.on("update-right-status", function(window, _)
    local leader = ""
    local mode = ""
    if window:leader_is_active() then
      leader = " LDR"
    end
    if window:active_key_table() then
      mode = " " .. string.upper(window:active_key_table())
    end
    window:set_right_status(wezterm.format {
      { Background = { Color = colors.color1 } },
      { Foreground = { Color = colors.background_color } },
      { Text = leader },
      { Background = { Color = colors.color1 } },
      { Foreground = { Color = colors.background_color } },
      { Text = mode },
      { Background = { Color = colors.color1 } },
      { Foreground = { Color = colors.background_color } },
      { Text = " " .. window:active_workspace() }
    })
  end);
end

return M
