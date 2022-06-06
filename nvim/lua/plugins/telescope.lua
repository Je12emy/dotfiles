require('telescope').setup {
    file_ignore_patterns = {"dist/*", "node_modules/*"},
    shorten_path = true,
    color_devicons = true,
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
    },
    pickers = {
      buffers = {
        theme = "dropdown",
      }
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Telescope mappings
vim.keymap.set( 'n',   '<Space>ff', ':Telescope find_files<CR>')
vim.keymap.set( 'n',   '<Space>fb', ':Telescope buffers<CR>')
vim.keymap.set( 'n',   '<Space>fc', ':Telescope git_commits<CR>')
vim.keymap.set( 'n',   '<Space>fr', ':Telescope git_branches<CR>')
vim.keymap.set( 'n',   '<Space>fm', ':Telescope marks<CR>')
vim.keymap.set( 'n',   '<Space>fk', ':Telescope keymaps<CR>')
vim.keymap.set( 'n',   '<Space>fz', ':Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set( 'n',   '<Space>fg', ':Telescope live_grep<CR>')
