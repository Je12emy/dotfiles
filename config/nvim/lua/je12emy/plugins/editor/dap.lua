return {
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local set = require("je12emy.utils.map")

            set.nmap("<Leader>do", dapui.open, { desc = "DAP open UI" });
            set.nmap("<Leader>dc", dapui.close, { desc = "DAP close UI" });

            dapui.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     dapui.close()
            -- end
        end,
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local set = require("je12emy.utils.map")
            local dap = require("dap")

            set.nmap("<Leader>d<Space>", dap.continue, { desc = "DAP continue" });
            set.nmap("<Leader>dt", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" });
            set.nmap("<Leader>dj", dap.step_over, { desc = "DAP step over" });
            set.nmap("<Leader>dh", dap.step_out, { desc = "DAP step out" });
            set.nmap("<Leader>dl", dap.step_into, { desc = "DAP step into" });
            set.nmap("<Leader>dT",
                function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            set.nmap('<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end)

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }

            dap.adapters.coreclr = {
                type = 'executable',
                command = '/usr/local/netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }
        end,
    }
}
