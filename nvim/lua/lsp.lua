local nvim_lsp = require 'lspconfig'
require('plugins/lsp-kind')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(client, bufnr)
    -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "cr", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "ci", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "cd", vim.lsp.buf.definition, { buffer = 0 })
    -- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.formatting, { buffer = 0 })
    vim.keymap.set("n", "cl", vim.diagnostic.setloclist, { buffer = 0 })
    vim.keymap.set("n", "ce", vim.diagnostic.open_float , { buffer = 0 })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev , { buffer = 0 })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next , { buffer = 0 })
end

-- Enabled Language Servers
require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.tailwindcss.setup{}

require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
