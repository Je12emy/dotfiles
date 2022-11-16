local ok, neotree = pcall(require, 'neo-tree')
if not ok then return end

neotree.setup({
    window = {
        position = "current",
        mapping_options = {noremap = true, nowait = true}
    },
    hijack_netrw_behavior = "open_default"
})

vim.keymap.set('n', '<a-e>', '<cmd>NeoTreeRevealToggle<CR>')