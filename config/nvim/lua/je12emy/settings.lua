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
-- Winbar (for nvim 0.8+)
-- Check https://github.com/ecosse3/nvim/blob/master/lua/autocmds.lua#L15-L45
if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
    callback = function()
      local winbar_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "TelescopePrompt",
        "DressingInput",
        "DressingSelect",
        "neotest-summary",
      }

      if (vim.api.nvim_win_get_config(0).relative ~= "") then
        return
      end

      if vim.bo.filetype == 'toggleterm' then
        return
      end

      if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end

      if vim.bo.filetype == 'GitBlame' then
        local hl_group = "EcovimSecondary"
        vim.opt_local.winbar = " " .. "%#" .. hl_group .. "#" .. require('icons').git .. "Blame" .. "%*"
        return
      end

      vim.opt_local.winbar = '%=%m %t'
    end,
  })
end

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
