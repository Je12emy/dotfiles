local tools = require 'utils/lsp_tools'

local capabilities = tools.get_capabilities()

require('rust-tools').setup({
        server = {
            on_attach = tools.on_attach,
            capabilities = capabilities,
        },
})
