require("bufferline").setup{
        options = {
                separator_style = "thin",
                diagnostics = "nvim_lsp",
        }
}

vim.keymap.set( 'n',   '<a-}>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set( 'n',   '<a-{>', '<cmd>BufferLineCyclePrev<CR>')
vim.keymap.set( 'n',   '<a-]>', '<cmd>BufferLineMoveNext<CR>')
vim.keymap.set( 'n',   '<a-[>', '<cmd>BufferLineMovePrev<CR>')
vim.keymap.set( 'n',   '<a-x>', '<cmd>bdelete<CR>')
