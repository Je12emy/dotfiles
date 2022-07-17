local g = vim.g
local set = vim.opt
local bo = vim.bo
local o = vim.o

g.mapleader = ' '
set.syntax = 'on'
set.mouse = 'a'
set.termguicolors = true
set.errorbells = false
set.relativenumber =  true
set.number =  true
set.hidden =  true
set.tabstop = 4 
set.softtabstop = 4
bo.swapfile = false
set.shiftwidth = 4
o.background = "dark" -- or "light" for light mode
set.expandtab = true
set.smartindent = true
set.wrap = false
set.smartcase = true
set.incsearch = true
set.clipboard = 'unnamed'
set.clipboard = 'unnamedplus'
set.hlsearch = true
set.laststatus = 3
o.timeoutlen = 3000
set.cursorline = true
set.wrapscan = true
set.spelllang = {'en','es'}
set.colorcolumn = '80'
set.laststatus = 3
set.winbar = '%=%m %f'
set.undodir = os.getenv("HOME") .. "/.undodir"
set.undofile = true
set.cmdheight=0
-- show whitespaces correctly
o.list = true
set.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- move cursor to next line when line ends
o.whichwrap = "b,s,<,>,[,],h,l"

-- split management
o.splitbelow = true
o.splitright = true
o.completeopt = 'menuone,noselect'
