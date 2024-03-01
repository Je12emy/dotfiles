return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function()
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "]h", gs.next_hunk, { desc = "] Next [H]unk" })
                vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "[ Prev [H]unk" })
                vim.keymap.set({ "n", "v" }, "<leader>ghs", function()
                        gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
                    end,
                    { desc = "[G]it [H]unk [S]tage" })
                vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>",
                    { desc = "[G]it [H]unk [R]eset" })
                vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "[G]it [H]unk [S]tage Buffer" })
                vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "[G]it [H]unk [U]nstage" })
                vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "[G]it [H]unk [R]eset Buffer]" })
            end
        }
    }
}
