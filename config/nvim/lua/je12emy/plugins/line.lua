return {
	{
		"strash/everybody-wants-that-line.nvim",
		opts = {
			filepath = {
				enabled = true,
				-- `path` can be one of these:
				-- "tail" - file name only
				-- "relative" - relative to working directory
				-- "full" - full path to the file
				path = "relative",
				-- If `true` a path will be shortened, e.g. "/a/b/c/filename.lua".
				-- It only works if `path` is "relative" or "full".
				shorten = true,
			},
			buffer = {
				enabled = false,
			},
			separator = "",
		},
	},
}
