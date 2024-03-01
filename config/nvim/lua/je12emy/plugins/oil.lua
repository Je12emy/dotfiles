return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup {
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-v>"] = "actions.select_vsplit",
					["<C-s>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-x>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["."] = "actions.cd",
					["~"] = "actions.tcd",
					["g."] = "actions.toggle_hidden",
				},
				use_default_keymaps = false,
				default_file_explorer = true,
				view_options = {
					show_hidden = true
				}
			}
			vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "[O]pen [O]il" })
			-- Disable netrw
			---@diagnostic disable-next-line: undefined-global
			vim.g.loaded_netrw = 1
			---@diagnostic disable-next-line: undefined-global
			vim.g.loaded_netrwPlugin = 1
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
