local set = vim.opt
local bo = vim.bo
local o = vim.o

require("je12emy.utils.noobline")
local cmd = require("je12emy.utils.autocmd")

set.syntax = "on"
set.mouse = "a"
set.termguicolors = true
set.errorbells = false
set.relativenumber = true
set.number = true
set.hidden = true
set.tabstop = 4
set.softtabstop = 4
bo.swapfile = false
set.shiftwidth = 4
-- o.background = "dark" -- or "light" for light mode
set.expandtab = true
set.smartindent = true
set.wrap = false
set.smartcase = true
set.incsearch = true
set.clipboard = "unnamed"
set.clipboard = "unnamedplus"
set.hlsearch = true
set.laststatus = 3 -- Global statusline
o.timeoutlen = 3000
set.cursorline = true
set.wrapscan = true
set.spelllang = { "en", "es" }
-- set.colorcolumn = '80'
-- set.winbar = '%=%m %t'
set.undodir = os.getenv("HOME") .. "/.undodir"
set.undofile = true
-- Remove space under the statusline
set.cmdheight = 0
-- move cursor to next line when line ends
o.whichwrap = "b,s,<,>,[,],h,l"

-- split management
o.splitbelow = true
o.splitright = true
o.completeopt = "menuone,noselect"
set.filetype = "on"

cmd.auto_hide_status()
