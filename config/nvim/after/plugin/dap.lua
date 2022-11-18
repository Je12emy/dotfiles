local ok, dap = pcall(require, 'nvim-dap')
if not ok then return end

local ok, dapui = require("dapui")
if not ok then return end

dapui.setup()

vim.keymap.set('n', '<a-d>', dapui.toggle)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')))

vim.keymap.set('n', '<F1>', dap.step_back)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.continue)

dap.listeners.after.event_initialized["dapui_config"] =
    function() dapui.open() end

dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end

dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
