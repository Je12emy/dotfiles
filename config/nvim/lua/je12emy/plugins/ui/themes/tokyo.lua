return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			sidebars = "transparent",
			floats = "transparent",
		},
		terminal_colors = true,
		lualine_bold = false,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		require('lualine').setup {
			options = {
				theme = 'tokyonight'
			}
		}
		vim.cmd [[colorscheme tokyonight]]
	end
}
