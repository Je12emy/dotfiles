local M = {}

-- Shorthand for setting keymaps on "normal" mode
M.nmap = function(l, r, opts)
    vim.keymap.set("n", l, r, opts)
end

-- Shorthand for setting keymaps on "insert" mode
M.imap = function(l, r, opts)
    vim.keymap.set("i", l, r, opts)
end

return M
