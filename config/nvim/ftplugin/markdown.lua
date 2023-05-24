local settings = require 'je12emy.utils.file-settings'
local keymap = require "je12emy.utils.map"
local obsidian = require "je12emy.utils.obsidian"

obsidian.setup {
    vault_path = "/home/jeremy/notes"
}

keymap.nmap("<Space>oo", obsidian.open_note, { desc = "Open the current note in obsidian" })
keymap.nmap('<Space>ts', '<cmd>Telescope spell_suggest<cr>', { desc = "View spell suggestions" })
settings.notes(vim.opt)
