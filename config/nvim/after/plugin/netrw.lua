local g = vim.g
g.netrw_banner = 0
-- 1 - open files in a new horizontal split
-- 2 - open files in a new vertical split
-- 3 - open files in a new tab
-- 4 - open in previous window
g.netrw_browse_split = 2
vim.keymap.set('n', '<a-e>', '<cmd>Explore<CR>')
