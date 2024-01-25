local keymap = require "je12emy.utils.map"

keymap.imap('jk', '<Esc>', { desc = "Exit insert mode" })
keymap.nmap('<Leader>S', ':%s//g<Left><Left>', { desc = "Replace command" })
keymap.nmap('<Leader>h', ':exe "vertical resize -" .5<CR>', { desc = "Decrease split vertical size by 5" })
keymap.nmap('<Leader>l', ':exe "vertical resize +" .5<CR>', { desc = "Increase split vertical size by 5" })
keymap.nmap('<Leader>j', ':exe "resize -" .5<CR>', { desc = "Decrease split horizontal size by 5" })
keymap.nmap('<Leader>k', ':exe "resize +" .5<CR>', { desc = "Increase split horizontal size by 5" })
keymap.nmap('<Leader>tn', '<cmd>tabnew<CR>', { desc = "Create new tab" })
keymap.nmap('<Leader>tx', '<cmd>tabclose<CR>', { desc = "Close tab" })
keymap.nmap('<F8>', ':setlocal spell!<CR>', { desc = "Toggle spell check" })

-- local todo_file = os.getenv("todo_path") or "~/todo.txt"
-- keymap.nmap('<a-t>', ':tab e' .. todo_file .. '<CR>', { desc = "Edit todo list" })
