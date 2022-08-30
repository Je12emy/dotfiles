local ok, lualine = pcall(require, 'lualine')
if not ok then return end
local options = {
    theme = 'kanagawa',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''}
}

-- branch (git branch)
-- buffers (shows currently available buffers)
-- diagnostics (diagnostics count from your preferred source)
-- diff (git diff status)
-- encoding (file encoding)
-- fileformat (file format)
-- filename
-- filesize
-- filetype
-- hostname
-- location (location in file in line:column format)
-- mode (vim mode)
-- progress (%progress in file)
-- tabs (shows currently available tabs)
-- windows (shows currently available windows)
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

local sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
}

lualine.setup({
    options = options,
    sections = sections,
})
