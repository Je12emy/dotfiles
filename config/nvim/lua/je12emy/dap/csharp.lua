-- Source: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Dotnet
-- Check the release page for https://github.com/Samsung/netcoredbg
local dap = require("dap")

dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/',
                                'file')
        end
    }
}
