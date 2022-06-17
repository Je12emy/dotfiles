-- General
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')

---- Navigation Keymaps
vim.keymap.set('n', '<c-h>', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<c-j>', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<c-l>', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<c-k>', '<cmd>wincmd k<CR>')

-- Window Split Manipulation
vim.keymap.set( 'n',   '<Space>wv', '<C-w>v<CR>')
vim.keymap.set( 'n',   '<Space>ws', '<C-w>s<CR>')
vim.keymap.set( 'n',   '<Space>wh', ':exe "vertical resize -" .5<CR>')
vim.keymap.set( 'n',   '<Space>wl', ':exe "vertical resize +" .5<CR>')
vim.keymap.set( 'n',   '<Space>wj', ':exe "resize -" .5<CR>')
vim.keymap.set( 'n',   '<Space>wk', ':exe "resize +" .5<CR>')
vim.keymap.set( 'n',   '<Space>wr', '<C-w>=<CR>')

-- Writting
vim.keymap.set( 'n',   '<F8>', ':setlocal spell!<CR>')
