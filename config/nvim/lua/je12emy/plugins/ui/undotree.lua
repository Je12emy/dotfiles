return {
	{
		"mbbill/undotree",
		event = { "BufReadPost", "BufNewFile" },
		keys = { { "<a-u>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
		cmd = "UndoTreeToggle",
	},
}
