local tools = {}

function tools.on_attach(client, bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover,
        { buffer = 0, desc = "Show documentation" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename,
        { buffer = 0, desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
        { buffer = 0, desc = "Show code actions" })
    vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation,
        { buffer = 0, desc = "Show implementations" })
    vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition,
        { buffer = 0, desc = "Show definitions" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
        { buffer = 0, desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
        { buffer = 0, desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<leader><leader>f", vim.lsp.buf.format,
        { buffer = 0, desc = "Format buffer" })
end

return tools
