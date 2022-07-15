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

require'lspconfig'.eslint.setup{
    on_attach = tools.on_attach,
    capabilities = capabilities,
}

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "/home/jeremy/source/omnisharp-linux-x64-net6.0/OmniSharp"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = tools.on_attach,
    capabilities = capabilities,
}
