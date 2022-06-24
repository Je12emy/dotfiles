local tools = require 'utils/lsp_tools'

local capabilities = tools.get_capabilities()

require('rust-tools').setup({
        dap = {
            adapter = {
                type = 'executable',
                command = 'lldb-vscode-14', -- sudo apt-get install lldb
                name = "rt_lldb"
            }
        },
        server = {
            on_attach = tools.on_attach,
            capabilities = capabilities,
        },
})
