local builtin = require("telescope.builtin")
vim.keymap.map("n", "z=", builtin.pell_suggest, { desc = "View spell suggestions" })

vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.spell = true
vim.opt.autowriteall = true
