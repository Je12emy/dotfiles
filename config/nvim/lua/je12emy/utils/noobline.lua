-- Noobline
-- Reference: https://nihilistkitten.me/nvim-lua-statusline/
local tmux = require("je12emy.utils.tmux")

-- Source: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/feline.lua#L45
local mode_colors = {
	["n"] = { "NORMAL" },
	["no"] = { "N-PENDING" },
	["i"] = { "INSERT" },
	["ic"] = { "INSERT" },
	["t"] = { "TERMINAL" },
	["v"] = { "VISUAL" },
	["V"] = { "V-LINE" },
	[""] = { "V-BLOCK" },
	["R"] = { "REPLACE" },
	["Rv"] = { "V-REPLACE" },
	["s"] = { "SELECT" },
	["S"] = { "S-LINE" },
	[""] = { "S-BLOCK" },
	["c"] = { "COMMAND" },
	["cv"] = { "COMMAND" },
	["ce"] = { "COMMAND" },
	["r"] = { "PROMPT" },
	["rm"] = { "MORE" },
	["r?"] = { "CONFIRM" },
	["!"] = { "SHELL" },
}

local spacer = " "

local function get_mode_text()
	return mode_colors[vim.fn.mode()][1]
end

local function get_current_branch()
	-- Source for this: https://www.reddit.com/r/neovim/comments/xtynan/show_me_your_statusline_big_plus_if_you_wrote_it/
	if vim.g.loaded_fugitive then
		local branch = vim.fn.FugitiveHead()
		if branch ~= "" then
			return "" .. spacer .. branch .. spacer
		end
	end
	return ""
end

local function get_modified_symbol(bufnr)
	if vim.bo[bufnr].readonly then
		return "" .. spacer
	end
	if vim.bo[bufnr].modified then
		return "" .. spacer
	end
	return "" .. spacer
end

local special_file_names = {
	["fugitive"] = { "Fugitive" },
	["oil"] = { "Oil" },
}

local function get_file_name(bufnr, show_icon)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	for key, _ in pairs(special_file_names) do
		if filename == "" then
			return "[No Name]"
		end
		if string.match(filename, key) then
			return special_file_names[key][1]
		end
	end
	local basename = vim.fn.fnamemodify(filename, ":t")
	local filetype = vim.bo[bufnr].filetype
	if show_icon then
		if require("nvim-web-devicons").has_loaded() then
			return require("nvim-web-devicons").get_icon(filename, filetype, { default = true }) .. spacer .. basename
		end
	end
	return basename
end

function Noob_status()
	return table.concat({
		spacer,
		get_current_branch(),
		"%=",
		get_file_name(0, false),
		spacer,
		-- get_modified_symbol(0),
		-- get_mode_text(),
	})
end

-- Based on this plugin: https://github.com/mkitt/tabline.vim/blob/master/plugin/tabline.vim
function Noob_tab()
	local tab_count = vim.fn.tabpagenr("$")
	local s = {}

	for i = 1, tab_count do
		local tab = i
		local winnr = vim.fn.tabpagewinnr(tab)
		local buflist = vim.fn.tabpagebuflist(tab)
		local bufnr = buflist[winnr]

		local tab_line = {}
		-- table.insert(tab_line, '%' .. tab .. 'T')
		-- table.insert(tab_line, ' ' .. i .. ':') -- Shows the tab index, it rarely use more than 3 tabs
		table.insert(tab_line, (tab == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#"))
		table.insert(tab_line, " ")
		table.insert(tab_line, get_file_name(bufnr, false))
		table.insert(tab_line, " ")

		table.insert(s, table.concat(tab_line))
	end
	table.insert(s, "%#TabLineFill#")
	return table.concat(s)
end

vim.o.statusline = "%!luaeval('Noob_status()')"
vim.o.tabline = "%!luaeval('Noob_tab()')"
