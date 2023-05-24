local Job = require "plenary.job"

local M = {}

local vault_path = nil
local cmd = "xdg-open"

-- Opens the current buffer in obsidian
-- source: https://github.com/epwalsh/obsidian.nvim/blob/main/lua/obsidian/command.lua#L162
local function open_obsidian_note(note)
    local uri = ("obsidian://open?file=%s"):format(note)
    local args = { uri }

    Job:new({
        command = cmd,
        args = args,
        on_exit = vim.schedule_wrap(function(_, return_code)
            if return_code > 0 then
                print("failed opening Obsidian app to note")
            end
        end),
    }):start()
end

-- Checks if the current file is in the vault folder
local function is_in_vault(note)
    if string.find(note, vault_path) then
        return true
    end
    return false
end

M.open_note = function()
    local path = vim.api.nvim_buf_get_name(0)
    local basename = vim.fn.fnamemodify(path, ":t")
    if is_in_vault(path) then
        print("Opening note")
        return open_obsidian_note(basename)
    end
    return print("Not in a obsidian vault")
end

M.setup = function(opts)
    vault_path = opts.vault_path
    vim.api.nvim_create_user_command("ObsidianOpen", M.open_note, {})
end

return M
