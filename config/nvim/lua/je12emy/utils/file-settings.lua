local M = {}

-- General purpose settings for note taking
M.notes = function(file)
    file.colorcolumn = '0'
    file.linebreak = true
    file.wrap = true
    file.breakindent = true
    file.spell = true
    file.autowriteall = true
    file.spelllang = { 'en', 'es' }
end

return M
