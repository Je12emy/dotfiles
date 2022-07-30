require("mason").setup()
require("mason-lspconfig").setup()

local lsp = require 'lspconfig'
local tools = require 'je12emy.lsp.lsp-tools'

local capabilities = tools.get_capabilities()

require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "gopls", }
})

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        lsp[server_name].setup {
            on_attach = tools.on_attach,
            capabilities = capabilities,
        }
    end,
}
