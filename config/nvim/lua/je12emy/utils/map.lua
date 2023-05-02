local M = {}

M.nmap = function(l, r, opts)
    vim.keymap.set("n", l, r, opts)
end

M.imap = function(l, r, opts)
    vim.keymap.set("i", l, r, opts)
end

return M
