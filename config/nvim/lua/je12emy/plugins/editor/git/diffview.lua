return {
	{
		"sindrets/diffview.nvim",
		enabled = true,
		requires = "nvim-tree/nvim-web-devicons",
		lazy = true,
		cmd = "DiffviewOpen",
		keys = {
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{
				"<leader>gdr",
				"<cmd>DiffviewRefresh<cr>",
				desc = "Refresh Diffview",
			},
			{
				"<leader>gdf",
				"<cmd>DiffviewToggleFiles<cr>",
				desc = "Toggle Diffview Files",
			},
		},
	},
}
