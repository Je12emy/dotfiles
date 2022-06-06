local dap = require('dap')

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<F1>', dap.step_back)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<F5>', dap.continue)

-- Reference
-- nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
-- nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <leader>B :"lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

-- Go Setup
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/source/vscode-go/dist/debugAdapter.js'};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}

require('dapui').setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set('n', '<Leader>dt', dapui.toggle)

local dapgo = require('dap-go')
dapgo.setup()
vim.keymap.set('n', '<leader>ddt', dapgo.debug_test)
