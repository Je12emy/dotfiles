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

local spacer = " "

local function get_mode_text()
    return mode_colors[vim.fn.mode()][1]
end

local function get_current_branch()
    -- Source for this: https://www.reddit.com/r/neovim/comments/xtynan/show_me_your_statusline_big_plus_if_you_wrote_it/
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then return "" .. spacer .. branch .. spacer end
    end
    return ""
end

local function get_modified_symbol()
    if (vim.bo.readonly) then
        return "" .. spacer
    end
    if (vim.bo.modified) then
        return "" .. spacer
    end
    return "" .. spacer
end

local function get_file_name()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
        return "[No Name]"
    end
    local basename = vim.fn.fnamemodify(filename, ":t")
    local filetype = vim.bo.filetype
    if require 'nvim-web-devicons'.has_loaded() then
        return require 'nvim-web-devicons'.get_icon(filename, filetype, { default = true }) .. spacer .. basename
    end
    return basename
end

function Status_line()
    return table.concat {
        spacer,
        get_modified_symbol(),
        get_mode_text(),
        "%=",
        get_current_branch(),
        get_file_name(),
        spacer
    }
end

vim.o.statusline = "%!luaeval('Status_line()')"
