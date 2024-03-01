return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = 'VeryLazy',
		branch = '0.1.x',
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
		config = function()
			require("telescope").setup {
				file_ignore_patterns = {
					"dist/*",
					"node_modules/*",
					"target/*",
					"*.png",
					"*.svg",
				},
				shorten_path = true,
				color_devicons = true,
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}

			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			local builtin = require 'telescope.builtin'
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = '[S]earch [F]iles' })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = '[S]earch [D]iagnostics ("." to repeat)' })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]search [K]eymaps" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = '[S]earch by [G]rep' })
		end,
	},
}
