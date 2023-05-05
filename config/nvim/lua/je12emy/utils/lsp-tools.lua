local keymap = require "je12emy.utils.map"

local M = {}

-- Callback for setting up rust tools keymaps
local function setup_rust_tools(client, bufnr)
    local rt = require("rust-tools")
    keymap.nmap("K", rt.hover_actions.hover_actions,
        { buffer = 0, desc = "Show rust hover actions" })
end

-- Callback for setting all my LSP keymaps
M.on_attach = function(client, bufnr)
    keymap.nmap("K", vim.lsp.buf.hover,
        { buffer = 0, desc = "Show documentation" })
    keymap.nmap("<leader>cr", vim.lsp.buf.rename,
        { buffer = 0, desc = "Rename symbol" })
    keymap.nmap("<leader>ca", vim.lsp.buf.code_action,
        { buffer = 0, desc = "Show code actions" })
    keymap.nmap("<leader>ci", vim.lsp.buf.implementation,
        { buffer = 0, desc = "Show implementations" })
    keymap.nmap("<leader>cd", vim.lsp.buf.definition,
        { buffer = 0, desc = "Show definitions" })
    keymap.nmap("[d", vim.diagnostic.goto_prev,
        { buffer = 0, desc = "Go to previous diagnostic" })
    keymap.nmap("]d", vim.diagnostic.goto_next,
        { buffer = 0, desc = "Go to next diagnostic" })
    keymap.nmap("<leader><leader>f", vim.lsp.buf.format,
        { buffer = 0, desc = "Format buffer" })
    keymap.imap("<c-k>", vim.lsp.buf.signature_help,
        { buffer = 0, desc = "Show completition item" })

    if (client.name == "rust_analyzer") then
        setup_rust_tools(client, bufnr)
    end
end

return M
