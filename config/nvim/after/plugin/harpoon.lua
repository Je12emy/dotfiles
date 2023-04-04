local ok, harpoon = pcall(require, 'harpoon')
if not ok then return end
harpoon.setup()

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<Space>ha', mark.add_file)
-- vim.keymap.set('n', '<Space>hm', ui.toggle_quick_menu)
vim.keymap.set('n', '<Space>hn', ui.nav_next)
vim.keymap.set('n', '<Space>hp', ui.nav_prev)

-- require("telescope").load_extension('harpoon')
-- vim.keymap.set('n', '<Space>th', "<cmd>Telescope harpoon marks<CR>")
