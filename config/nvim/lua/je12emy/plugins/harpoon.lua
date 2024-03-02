return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon Marks",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end, { desc = "[h]arpoon [a]ppend mark" })
		vim.keymap.set("n", "<leader>h}", function()
			harpoon:list():next()
		end, { desc = "[h]arpoon } next mark" })
		vim.keymap.set("n", "<leader>h{", function()
			harpoon:list():prev()
		end, { desc = "[h]arpoon { prev mark" })
		vim.keymap.set("n", "<leader>hc", function()
			harpoon:list():clear()
		end, { desc = "[h]arpoon [c]lean marks" })
		vim.keymap.set("n", "<leader>sh", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[s]earch [h]arpoon marks" })
	end,
}
