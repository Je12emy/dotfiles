return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function()
				local gs = package.loaded.gitsigns

				vim.keymap.set("n", "]h", gs.next_hunk, { desc = "next [h]unk" })
				vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "prev [h]unk" })
				vim.keymap.set({ "n", "v" }, "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[g]it [h]unk [s]tage" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ghr",
					":Gitsigns reset_hunk<CR>",
					{ desc = "[g]it [h]unk [r]eset" }
				)
				vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "[g]it [h]unk [S]tage all" })
				vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "[g]it [h]unk [u]nstage" })
				vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "[g]it [h]unk [R]eset Buffer]" })
			end,
		},
	},
}
