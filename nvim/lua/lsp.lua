require('plugins/lsp-kind')
local nvim_lsp = require 'lspconfig'
local tools = require 'utils/lsp_tools'

local capabilities = tools.get_capabilities()

-- Enabled Language Servers
require'lspconfig'.gopls.setup{
    on_attach = tools.on_attach,
    capabilities = capabilities,
}

require'lspconfig'.tsserver.setup{
    on_attach = tools.on_attach,
    capabilities = capabilities,
}

require'lspconfig'.cssls.setup{
    on_attach = tools.on_attach,
    capabilities = capabilities,
}

require'lspconfig'.tailwindcss.setup{}

require'lspconfig'.rust_analyzer.setup{
    on_attach = tools.on_attach,
    capabilities = capabilities,
}
