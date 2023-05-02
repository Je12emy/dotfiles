-- Noobline
-- Reference: https://nihilistkitten.me/nvim-lua-statusline/

-- Source: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/feline.lua#L45
local mode_colors = {
    ["n"] = { "NORMAL" },
    ["no"] = { "N-PENDING" },
    ["i"] = { "INSERT" },
    ["ic"] = { "INSERT" },
    ["t"] = { "TERMINAL" },
    ["v"] = { "VISUAL" },
    ["V"] = { "V-LINE" },
    [""] = { "V-BLOCK" },
    ["R"] = { "REPLACE" },
    ["Rv"] = { "V-REPLACE" },
    ["s"] = { "SELECT" },
    ["S"] = { "S-LINE" },
    [""] = { "S-BLOCK" },
    ["c"] = { "COMMAND" },
    ["cv"] = { "COMMAND" },
    ["ce"] = { "COMMAND" },
    ["r"] = { "PROMPT" },
    ["rm"] = { "MORE" },
    ["r?"] = { "CONFIRM" },
    ["!"] = { "SHELL" },
}

local function get_mode_text()
    return mode_colors[vim.fn.mode()][1]
end

local function get_modified_symbol()
    if (vim.bo.readonly) then
        return " "
    end
    if (vim.bo.modified) then
        return " "
    end
    return " "
end

local spacer = " "

function Status_line()
    return table.concat {
        spacer,
        get_modified_symbol(),
        get_mode_text(),
        "%=",
        "%t",
        spacer
    }
end

vim.o.statusline = "%!luaeval('Status_line()')"
