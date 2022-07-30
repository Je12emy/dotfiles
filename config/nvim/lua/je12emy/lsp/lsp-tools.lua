local tools = {}

function tools.on_attach(client, bufnr)
    -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, {buffer = 0})
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {buffer = 0})
    vim.keymap.set("n", "<Leader>ci", vim.lsp.buf.implementation, {buffer = 0})
    vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, {buffer = 0})
    -- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.formatting, { buffer = 0 })
    vim.keymap.set("n", "<Leader>cl", vim.diagnostic.setloclist, {buffer = 0})
    vim.keymap.set("n", "<Leader>ce", vim.diagnostic.open_float, {buffer = 0})
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "<Leader>dl", vim.diagnostic.setqflist, {buffer = 0})
    vim.keymap.set("n", "<Leader>dh", vim.diagnostic.hide, {buffer = 0})
    vim.keymap.set("n", "<Leader>ds", vim.diagnostic.show, {buffer = 0})
end

function tools.get_capabilities(client, bufnr)
    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    return capabilities
end

return tools
