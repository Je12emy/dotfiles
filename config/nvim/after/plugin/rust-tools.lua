local ok, rust_tools = pcall(require, 'rust-tools')
if not ok then return end
local tools = require 'je12emy/lsp/lsp-tools'
local capabilities = tools.get_capabilities()
rust_tools.setup({
    dap = {
        adapter = {
            type = 'executable',
            command = 'lldb-vscode-14', -- sudo apt-get install lldb
            name = "rt_lldb"
        }
    },
    server = {on_attach = tools.on_attach, capabilities = capabilities}
})
