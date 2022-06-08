-- General
vim.keymap.set('i', 'jk', '<Esc>')
-- I believe this is causing my keymaps which use <Leader> to not work lol
-- vim.keymap.set("n", '<Leader>', '<Nop>') 
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')

---- Navigation Keymaps
vim.keymap.set('n', '<c-h>', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<c-j>', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<c-l>', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<c-k>', '<cmd>wincmd k<CR>')

-- Window Split Manipulation
vim.keymap.set( 'n',   '<Leader>wv', '<C-w>v<CR>')
vim.keymap.set( 'n',   '<Leader>ws', '<C-w>s<CR>')
vim.keymap.set( 'n',   '<Leader>wh', ':exe "vertical resize -" .5<CR>')
vim.keymap.set( 'n',   '<Leader>wl', ':exe "vertical resize +" .5<CR>')
vim.keymap.set( 'n',   '<Leader>wj', ':exe "resize -" .5<CR>')
vim.keymap.set( 'n',   '<Leader>wk', ':exe "resize +" .5<CR>')
vim.keymap.set( 'n',   '<Leader>wr', '<C-w>=<CR>')

-- Buffer Management
vim.keymap.set( 'n',   '<c-n>', '<cmd>bnext<CR>')
vim.keymap.set( 'n',   '<c-p>', '<cmd>previous<CR>')
vim.keymap.set( 'n',   '<Leader>bd', '<cmd>bdelete<CR>')

-- Writting
vim.keymap.set( 'n',   '<F8>', ':setlocal spell!<CR>')
