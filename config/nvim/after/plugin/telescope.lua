local ok, telescope = pcall(require, 'telescope')
if not ok then return end
telescope.setup {
    file_ignore_patterns = {
        "dist/*", "node_modules/*", "build/*", "target/*", "*.png", "*.svg"
    },
    shorten_path = true,
    color_devicons = true,
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
    pickers = {}
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
-- Telescope mappings
vim.keymap.set('n', '<Leader>tf', ':Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>tb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>tm', ':Telescope marks<CR>')
vim.keymap.set('n', '<Leader>tk', ':Telescope keymaps<CR>')
vim.keymap.set('n', '<Leader>tz', ':Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set('n', '<Leader>tg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>tc', ':Telescope commands<CR>')
