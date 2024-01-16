return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["x"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["."] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			use_default_keymaps = false,
			default_file_explorer = true,
		},
		config = function(_, opts)
			require("oil").setup(opts)
			local keymap = require("je12emy.utils.map")
			keymap.nmap("<a-e>", "<cmd>Oil<CR>", { desc = "Open Oil" })
			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
