local ok, gruvbox = pcall(require, 'gruvbox')
if not ok then return end
gruvbox.setup({
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {
        dark0_hard = "#1c2021",
    }
})
vim.o.background = "dark"
