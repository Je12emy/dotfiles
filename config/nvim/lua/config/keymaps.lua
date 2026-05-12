-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit edit mode" })
vim.keymap.set("t", "<c-n><c-n>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
