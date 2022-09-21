local g = vim.g
local set = vim.opt
local bo = vim.bo
local o = vim.o

g.mapleader = ' '
set.syntax = 'on'
set.mouse = 'a'
set.termguicolors = true
set.errorbells = false
set.relativenumber = true
set.number = true
set.hidden = true
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
set.spelllang = {'en', 'es'}
-- set.colorcolumn = '80'
-- Global status line
set.laststatus = 3
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
o.completeopt = 'menuone,noselect'
set.filetype = "on"

-- TODO make this auto command work in ftdetect
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.astro",
    command = "set filetype=astro"
})

vim.api.nvim_create_autocmd('RecordingEnter', {
    pattern = '*',
    callback = function() vim.opt_local.cmdheight = 1 end
})

vim.api.nvim_create_autocmd('RecordingLeave', {
    pattern = '*',
    callback = function()
        local timer = vim.loop.new_timer()
        -- NOTE: Timer is here because we need to close cmdheight AFTER
        -- the macro is ended, not during the Leave event
        timer:start(50, 0, vim.schedule_wrap(
                        function() vim.opt_local.cmdheight = 0 end))
    end
})

local file_settings = {}
-- General purpose settings for note taking
function file_settings.notes(file)
    file.colorcolumn = '0'
    file.linebreak = true
    file.wrap = true
    file.spell = true
    file.autowriteall = true
    file.spelllang = {'en', 'es'}
end

return file_settings
