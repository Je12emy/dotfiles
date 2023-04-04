return {
    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        lazy = false,
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']h', function()
                    if vim.wo.diff then return ']h' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr = true})

                map('n', '[h', function()
                    if vim.wo.diff then return '[h' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr = true})

                -- Actions
                map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hb',
                    function() gs.blame_line {full = true} end)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hx', gs.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        }
    }, {
        "tpope/vim-fugitive",
        lazy = true,
        cmd = "G",
        keys = {{"<leader>gg", "<cmd>tab G<cr>"}}
    }, {
        'sindrets/diffview.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        lazy = true,
        cmd = "DiffviewOpen",
        keys = {
            {"<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview"},
            {
                "<leader>gdr",
                "<cmd>DiffviewRefresh<cr>",
                desc = "Refresh Diffview"
            },
            {
                "<leader>gdf",
                "<cmd>DiffviewToggleFiles<cr>",
                desc = "Toggle Diffview Files"
            }
        }
    }
}
