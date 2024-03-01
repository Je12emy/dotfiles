local settings = require 'je12emy.utils.file-settings'
local keymap = require "je12emy.utils.map"
keymap.nmap('z=', '<cmd>Telescope spell_suggest<cr>', { desc = "View spell suggestions" })
settings.notes(vim.opt)
