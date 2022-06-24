local dap, dapui = require("dap"), require("dapui")

vim.keymap.set('n', '<a-d>', dapui.toggle)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<F1>', dap.step_back)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.continue)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- I need to reconfigure for Go
-- Go Setup
-- dap.adapters.go = {
--   type = 'executable';
--   command = 'node';
--   args = {os.getenv('HOME') .. '/source/vscode-go/dist/debugAdapter.js'};
-- }
-- dap.configurations.go = {
--   {
--     type = 'go';
--     name = 'Debug';
--     request = 'launch';
--     showLog = false;
--     program = "${file}";
--     dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
--   },
-- }

-- local dapgo = require('dap-go')
-- dapgo.setup()
-- vim.keymap.set('n', '<leader>ddt', dapgo.debug_test)
