local M = {}
-- source: https://github.com/alexghergh/nvim-tmux-navigation/blob/main/lua/nvim-tmux-navigation/tmux_util.lua
-- send the tmux command to the server running on the socket
-- given by the environment variable $TMUX
--
-- the check if tmux is actually running (so the variable $TMUX is
-- not nil) is made before actually calling this function
local function tmux_command(command)
    local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]
    return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
end

-- check whether the current tmux pane is zoomed
M.is_tmux_pane_zoomed = function()
    -- the output of the tmux command is "1\n", so we have to test against that
    return tmux_command("display-message -p '#{window_zoomed_flag}'") == "1\n"
end

return M
