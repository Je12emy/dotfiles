return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local set = require("je12emy.utils.map")
			local dap = require("dap")

			set.nmap("<Leader>d<Space>", dap.continue, { desc = "[D]ebug launch/continue" })

			-- NOTE: See all available DAP adapters here: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			dap.adapters.coreclr = {
				type = "executable",
				command = "/usr/local/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
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
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local set = require("je12emy.utils.map")

			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				set.nmap("<Leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [t]oggle breakpoint" })
				set.nmap("<Leader>dT", function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end, { desc = "[D]debug [T]oggle log point" })

				set.nmap("<Leader>dj", dap.step_over, { desc = "[D]debug [j]step over" })
				set.nmap("<Leader>dh", dap.step_out, { desc = "[D]debug [h]step out" })
				set.nmap("<Leader>dl", dap.step_into, { desc = "[D]debug [l]step into" })

				set.nmap("<Leader>dk", function()
					require("dap.ui.widgets").hover()
				end, { desc = "[D]debug [k]hover" })

				set.nmap("<Leader>do", dapui.open, { desc = "[D]ebug UI [o]pen" })
				set.nmap("<Leader>dc", dapui.close, { desc = "[D]ebug UI [c]lose" })
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
}
