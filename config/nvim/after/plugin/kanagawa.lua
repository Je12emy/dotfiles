local ok, kanagawa = pcall(require, 'kanagawa')
if not ok then return end
local my_colors = {
    bg = '#181820' -- I like this darker background
}
-- Default options:
kanagawa.setup({
    undercurl = true, -- enable undercurls
    commentStyle = {italic = true},
    functionStyle = {italic = true},
    keywordStyle = {italic = true},
    statementStyle = {bold = true},
    typeStyle = {},
    variablebuiltinStyle = {italic = true},
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true, -- adjust window separators highlight for laststatus=3
    -- colors = my_colors,
})
