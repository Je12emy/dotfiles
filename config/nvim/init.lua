--
-- ▐▓█▀▀▀▀▀▀▀▀▀█▓▌░▄▄▄▄▄░
-- ▐▓█░░▀░░▀▄░░█▓▌░█▄▄▄█░
-- ▐▓█░░▄░░▄▀░░█▓▌░█▄▄▄█░
-- ▐▓█▄▄▄▄▄▄▄▄▄█▓▌░█████░
-- ░░░░▄▄███▄▄░░░░░█████░
-- Single file neovim configuration, recently written based on
-- kickstart: https://github.com/nvim-lua/kickstart.nvim/tree/master
--
--
-- Settings
-- <Space> as my leader modifier key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.signcolumn = "yes"
-- Show the cursor line and make it relative
vim.opt.number = true
vim.opt.relativenumber = true
--- Enable mouse
vim.opt.mouse = "a"
vim.opt.showmode = false
-- Use the OS clipboard
vim.opt.clipboard = "unnamedplus"
-- When wrapping, indent the text
vim.opt.breakindent = true
-- Undo file keeps a history of your changes
vim.opt.undofile = true
-- Show a vertical indicator al line 80
vim.opt.colorcolumn = "80"
-- Available statusline options:
-- 1 No status line
-- 2 Regualar status line
-- 3 Global statusline
vim.opt.laststatus = 3
-- Don't wrap lines by default
vim.opt.wrap = false
-- Show a vertical cursor line
vim.opt.cursorline = true
-- Spellcheck languages
vim.opt.spelllang = { "en", "es" }
-- No error bells when deleting text
vim.opt.errorbells = false
-- A <Tab> is 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- When pressing <Tab> shift by 4 spaces
vim.opt.shiftwidth = 4
-- Enable vim's basic syntax highlights
vim.opt.syntax = "on"
-- Ignore casing when searching
vim.opt.smartcase = true
-- When searching with "]" or "[" wrap around the buffer
vim.opt.wrapscan = true
-- Control the space under the statusline, option are.
-- 0 hidden
-- 1 >= some height
vim.opt.cmdheight = 1
-- Enable file type detection
vim.opt.filetype = "on"
-- How much time should pass to register keymaps
vim.o.timeoutlen = 3000
-- How should we split
vim.o.splitbelow = true
vim.o.splitright = true
-- An extra statusline for each buffer, ideal when using a global statusline
-- vim.opt.winbar = "%=%m %t"
-- Allow the cursor to next line when line ends
vim.o.whichwrap = "b,s,<,>,[,],h,l"
-- Options for insert mode completition
-- see: "help cot"
vim.o.completeopt = "menu,menuone,noselect"
-- I hate the warning I get due to swap files
vim.opt.swapfile = false
-- cmd.auto_hide_status()
-- Base keymaps
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>s", ":%s//g<Left><Left>", { desc = "[s]ed command" })
vim.keymap.set("n", "<leader>h", ':exe "vertical resize -" .5<CR>', { desc = "-5 on vertical split" })
vim.keymap.set("n", "<leader>l", ':exe "vertical resize +" .5<CR>', { desc = "+5 on vertical split" })
vim.keymap.set("n", "<leader>j", ':exe "resize -" .5<CR>', { desc = "-5 on horizontal split" })
vim.keymap.set("n", "<leader>k", ':exe "resize +" .5<CR>', { desc = "+5 on horizontal split" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [n]ew" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab close [x]" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set({ "v", "n" }, "<leader>f", "<cmd>Format<CR> ", { desc = "[f]ormat buffer" })
-- Plugins setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Connect to godot's LSP server when a .gd file is opened
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	pattern = "*.gd",
-- 	callback = function()
-- 		if not vim.g.server_started then
-- 			vim.fn.serverstart("127.0.0.1:55432")
-- 			vim.g.server_started = true
-- 			vim.notify("GDScript server attached")
-- 		end
-- 	end
-- })
-- Plugins
require("lazy").setup({
	{
		-- Fuzzy Finder
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = "VeryLazy",
		branch = "0.1.x",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				file_ignore_patterns = {
					"dist/*",
					"node_modules/*",
					"target/*",
					"tmp",
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
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
					},
					grep_string = {
						theme = "cursor",
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp docs" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = '[s]earch [d]iagnostics ("." to repeat)' })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]search [k]eymaps" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[s]earch [b]uffers" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
			vim.keymap.set(
				"n",
				"<leader>s?",
				builtin.current_buffer_fuzzy_find,
				{ desc = "[s]earch in current buffer" }
			)
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
			vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "search spell suggestions" })
			vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "[s]earch [t]reesitter" })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[s]earch [c]commands" })
		end,
	},
	{
		-- Tree explorer like a buffer
		"stevearc/oil.nvim",
		config = function()
			-- helper function to parse output
			local function parse_output(proc)
				local result = proc:wait()
				local ret = {}
				if result.code == 0 then
					for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
						-- Remove trailing slash
						line = line:gsub("/$", "")
						ret[line] = true
					end
				end
				return ret
			end

			-- build git status cache
			local function new_git_status()
				return setmetatable({}, {
					__index = function(self, key)
						local ignore_proc = vim.system(
							{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
							{
								cwd = key,
								text = true,
							}
						)
						local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
							cwd = key,
							text = true,
						})
						local ret = {
							ignored = parse_output(ignore_proc),
							tracked = parse_output(tracked_proc),
						}

						rawset(self, key, ret)
						return ret
					end,
				})
			end
			local git_status = new_git_status()

			-- Clear git status cache on refresh
			local refresh = require("oil.actions").refresh
			local orig_refresh = refresh.callback
			refresh.callback = function(...)
				git_status = new_git_status()
				orig_refresh(...)
			end
			require("oil").setup({
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
					show_hidden = false,
					is_hidden_file = function(name, bufnr)
						local dir = require("oil").get_current_dir(bufnr)
						local is_dotfile = vim.startswith(name, ".") and name ~= ".."
						-- if no local directory (e.g. for ssh connections), just hide dotfiles
						if not dir then
							return is_dotfile
						end
						-- dotfiles are considered hidden unless tracked
						if is_dotfile then
							return not git_status[dir].tracked[name]
						else
							-- Check if file is gitignored
							return git_status[dir].ignored[name]
						end
					end,
				},
			})
			vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "[o]pen [o]il" })
			-- Disable netrw
			---@diagnostic disable-next-line: undefined-global
			vim.g.loaded_netrw = 1
			---@diagnostic disable-next-line: undefined-global
			vim.g.loaded_netrwPlugin = 1
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		-- Commenting shortcuts
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		-- Highlight TODO coments
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = true,
			format_on_save = false,
			-- NOTE: You can enable outformat if you want to with this
			-- format_on_save = {
			-- 	timeout_ms = 500,
			-- 	lsp_fallback = true,
			-- },
			formatters_by_ft = {
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters

				-- Stylua is available in your package manager or you could download the binary
				-- see: https://github.com/JohnnyMorganz/StyLua?tab=readme-ov-file#installation
				lua = { "stylua" },

				-- Prettier can be installed with npm:
				-- $ npm install -g prettier
				javascript = { "prettierd", "prettier" },
				astro = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },

				-- GDFormat is part of a godot toolkit
				-- $ paru python-gdtoolkit
				gdscript = { "gdformat" },

				-- C Sharpier can be installed with dotnet
				-- $ dotnet tool install csharpier -g
				-- see: https://github.com/belav/csharpier
				csharp = { "csharpier" },

				-- Gofmt should be included with your go installation, make sure "go/bin" is in your path
				go = { "gofmt" },

				-- Rustfmt  can be installed it with rustup
				-- $ rustup component add rustfmt
				-- see: https://github.com/rust-lang/rustfmt?tab=readme-ov-file#quick-start
				rust = { "rustfmt" },

				-- DJLint provies support for templating languages like Go's templating
				-- $ pip install djlint
				-- $ npm i djlint #requires pip and python still
				-- see: https://github.com/djlint/djLint?tab=readme-ov-file#-how
				html = { "djlint" },

				-- Basic SQL formatter.
				-- $ npm install sql-formatter
				-- see: https://github.com/sql-formatter-org/sql-formatter?tab=readme-ov-file#install
				sql = { "sql_formatter" },

				-- Laravel's Formatter
				-- See: https://github.com/laravel/pint
				php = { "pint" },
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			-- see: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range }, function(_, did_edit)
					if did_edit then
						vim.notify("Formated buffer")
					end
				end)
			end, { range = true })
		end,
	},
	{
		-- Git client
		"tpope/vim-fugitive",
		lazy = false,
		cmd = "G",
		keys = { { "<leader>gg", "<cmd>tab G<cr>" } },
	},
	{
		-- Better marks
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

			vim.keymap.set("n", "<leader>hm", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "[h]arpoon [m]enu" })
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
				vim.notify("Harpoon mark added")
			end, { desc = "[h]arpoon [a]ppend mark" })
			vim.keymap.set("n", "<leader>h}", function()
				harpoon:list():next()
			end, { desc = "[h]arpoon next mark" })
			vim.keymap.set("n", "<leader>h{", function()
				harpoon:list():prev()
			end, { desc = "[h]arpoon previous mark" })
			vim.keymap.set("n", "<leader>hc", function()
				harpoon:list():clear()
				vim.notify("Harpoon marks cleared")
			end, { desc = "[h]arpoon [c]lean marks" })
			vim.keymap.set("n", "<leader>sm", function()
				toggle_telescope(harpoon:list())
			end, { desc = "[s]earch harpoon [m]arks" })
		end,
	},
	{
		-- Git signs in the column + other Git utils
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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
			})
			vim.cmd.colorscheme("catppuccin")
		end
	},
	{
		-- Theme
		"folke/tokyonight.nvim",
		enable = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
				terminal_colors = true,
				lualine_bold = false,
				-- NOTE: Highlight groups here: https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
				on_highlights = function(hl, c)
					hl.TabLine = {
						bg = "NONE",
						fg = c.fg_dark,
					}
					hl.TabLineFill = {
						bg = "NONE",
						fg = c.fg_dark,
					}
					hl.MiniStatuslineFilename = {
						bg = "NONE",
						fg = c.fg_dark,
					}
					hl.MiniTablineFill = {
						bg = "NONE",
						fg = c.fg_dark,
					}
				end,
			})
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local treesiter = require("nvim-treesitter.configs")
			local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
			-- Taken from: https://github.com/EmranMR/tree-sitter-blade/discussions/19#discussioncomment-8541804
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade"
			}

			vim.filetype.add({
				pattern = {
					['.*%.blade%.php'] = 'blade',
				}
			})
			local bladeGrp
			vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				pattern = "*.blade.php",
				group = bladeGrp,
				callback = function()
					vim.opt.filetype = "blade"
				end,
			})
			treesiter.setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
					indent = { enable = true },
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			statusline.setup({
				set_vim_settings = false,
			})

			-- You can confiure sections in the statusline by overriding their
			-- default behavior. For example, here we disable the section for
			-- cursor information because line numbers are already enabled
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return ""
			end

			-- Simple notifications
			local notify = require("mini.notify")
			notify.setup()
			-- Wrap vim.notify with mini.notify and set some log leves
			vim.notify = notify.make_notify({
				ERROR = { duration = 5000 },
				WARN = { duration = 4000 },
				INFO = { duration = 3000 },
			})

			-- require("mini.tabline").setup()

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		-- Completition engine
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		enabled = false,
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			{
				"saadparwaiz1/cmp_luasnip",
				version = "v2.*",
				build = "make install_jsregexp",
				enabled = false,
			},
		},
	},
	{
		-- An extension for csharp lsp
		"Decodetalkers/csharpls-extended-lsp.nvim",
	},
	{
		'saghen/blink.cmp',
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = 'rafamadriz/friendly-snippets',

		-- use a release tag to download pre-built binaries
		version = 'v0.*',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- On musl libc based systems you need to add this flag
		-- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

		opts = {
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'normal',

			-- experimental auto-brackets support
			-- accept = { auto_brackets = { enabled = true } }

			-- experimental signature help support
			-- trigger = { signature_help = { enabled = true } }
		}
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- capabilities.textDocument.completion.completionItem.snippetSupport = true

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					vim.notify(client.name .. " LSP client ready")
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Show documentation" })
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						{ buffer = event.buf, desc = "[c]ode [r]ename symbol" }
					)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "[c]ode [a]ction" }
					)
					vim.keymap.set(
						"n",
						"gi",
						require("telescope.builtin").lsp_implementations,
						{ buffer = event.buf, desc = "[g]oto [i]implementation" }
					)
					vim.keymap.set(
						"n",
						"gr",
						require("telescope.builtin").lsp_references,
						{ buffer = event.buf, desc = "[g]oto [r]eferences" }
					)

					local dap = require("dap")
					vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [t]oggle breakpoint" })

					local clients = vim.lsp.get_active_clients()
					local is_csharp = false
					for _, client in ipairs(clients) do
						if client.name == "csharp_ls" then
							is_csharp = true
							break
						end
					end
					-- csharpls_extended does not support Telescope yet,
					-- see: https://github.com/Decodetalkers/csharpls-extended-lsp.nvim/pull/11
					vim.keymap.set("n", "gd", function()
						if is_csharp then
							vim.lsp.buf.definition()
							return
						end
						require("telescope.builtin").lsp_definitions()
					end, { buffer = event.buf, desc = "[g]oto [d]efinition" })

					vim.keymap.set(
						{ "i", "v" },
						"<c-k>",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Show signature" }
					)
				end,
			})
			-- NOTE: See all the available LSP client configurations here
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

			-- Install instructions here: https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
			-- In Linux, just add rust-analyzer yo your local binaries
			-- $ curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
			-- $ chmod +x ~/.local/bin/rust-analyzer
			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})
			-- Installable through go's module system
			-- see: go install golang.org/x/tools/gopls@latest
			-- $ go install golang.org/x/tools/gopls@latesto
			lspconfig.gopls.setup {}
			-- Available through npm
			-- $ npm install -g typescript typescript-language-server
			lspconfig.ts_ls.setup {}
			-- Available through npm
			-- $ npm i -g vscode-langservers-extracted
			lspconfig.cssls.setup({
			})
			-- Available through npm
			-- $ npm install -g @astrojs/language-server
			lspconfig.astro.setup {}
			-- Mostly available through package managers.
			-- see: https://luals.github.io/#neovim-install
			lspconfig.lua_ls.setup {}
			-- Check this guide: https://mb-izzo.github.io/nvim-godot-solution/
			-- require 'lspconfig'.gdscript.setup({
			-- 	capabilities = capabilities,
			-- })
			-- see: https://github.com/razzmatazz/csharp-language-server
			-- $ dotnet tool install --global csharp-ls
			local pid = vim.fn.getpid()
			lspconfig.csharp_ls.setup({
				handlers = {
					["textDocument/definition"] = require("csharpls_extended").handler,
					["textDocument/typeDefinition"] = require("csharpls_extended").handler,
				},
			})
			-- Available through your package manager or see the pre-built binaries
			-- see: https://github.com/artempyanykh/marksman/blob/main/docs/install.md
			lspconfig.marksman.setup {}
			-- see: https://phpactor.readthedocs.io/en/master/usage/standalone.html#phar-installation
			lspconfig.phpactor.setup {}
			-- See: https://github.com/tailwindlabs/tailwindcss-intellisense
			-- $ npm install -g @tailwindcss/language-server
			lspconfig.tailwindcss.setup{}
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<Leader>d<Space>", dap.continue, { desc = "[D]ebug launch/continue" })

			-- NOTE: See all available DAP adapters here: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

			require('dap-go').setup()
			-- dap.adapters.gdb = {
			-- 	type = "executable",
			-- 	command = "gdb",
			-- 	args = { "-i", "dap" },
			-- }
			--
			-- dap.adapters.coreclr = {
			-- 	type = "executable",
			-- 	command = "netcoredbg",
			-- 	args = { "--interpreter=vscode" },
			-- }

			-- dap.adapters.godot = {
			-- 	type = "server",
			-- 	host = '127.0.0.1',
			-- 	port = 6006,
			-- }

			-- dap.configurations.gdscript = {
			-- 	{
			-- 		type = "godot",
			-- 		request = "launch",
			-- 		name = "Launch scene",
			-- 		project = "${workspaceFolder}",
			-- 	}
			-- }

			-- dap.configurations.c = {
			-- 	{
			-- 		name = "Launch",
			-- 		type = "gdb",
			-- 		request = "launch",
			-- 		program = function()
			-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			-- 		end,
			-- 		cwd = "${workspaceFolder}",
			-- 	},
			-- }

			-- -- source: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
			-- vim.g.dotnet_build_project = function()
			-- 	local default_path = vim.fn.getcwd() .. "/"
			-- 	if vim.g["dotnet_last_proj_path"] ~= nil then
			-- 		default_path = vim.g["dotnet_last_proj_path"]
			-- 	end
			-- 	local path = vim.fn.input("Path to your *proj file", default_path, "file")
			-- 	vim.g["dotnet_last_proj_path"] = path
			-- 	local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
			-- 	print("")
			-- 	print("Cmd to execute: " .. cmd)
			-- 	local f = os.execute(cmd)
			-- 	if f == 0 then
			-- 		print("\nBuild: ✔️ ")
			-- 	else
			-- 		print("\nBuild: ❌ (code: " .. f .. ")")
			-- 	end
			-- end
			--
			-- vim.g.dotnet_get_dll_path = function()
			-- 	local request = function()
			-- 		return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			-- 	end
			--
			-- 	if vim.g["dotnet_last_dll_path"] == nil then
			-- 		vim.g["dotnet_last_dll_path"] = request()
			-- 	else
			-- 		if
			-- 			vim.fn.confirm(
			-- 				"Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
			-- 				"&yes\n&no",
			-- 				2
			-- 			) == 1
			-- 		then
			-- 			vim.g["dotnet_last_dll_path"] = request()
			-- 		end
			-- 	end
			--
			-- 	return vim.g["dotnet_last_dll_path"]
			-- end
			--
			-- local config = {
			-- 	{
			-- 		type = "coreclr",
			-- 		name = "launch - netcoredbg",
			-- 		request = "launch",
			-- 		program = function()
			-- 			if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
			-- 				vim.g.dotnet_build_project()
			-- 			end
			-- 			return vim.g.dotnet_get_dll_path()
			-- 		end,
			-- 	},
			-- }
			--
			-- dap.configurations.cs = config
		end,
		dependencies = {
			{
				"leoluz/nvim-dap-go",
			}
		}
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup {
				controls = {
					element = "scopes",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = ""
					}
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" }
					}
				},
				force_buffers = true,
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = ""
				},
				layouts = { {
					elements = { {
						id = "scopes",
						size = 0.3
					}, {
						id = "breakpoints",
						size = 0.3
					}, {
						id = "repl",
						size = 0.3
					}
					},
					position = "right",
					size = 40
				} },
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t"
				},
				render = {
					indent = 1,
					max_value_lines = 100
				}
			}

			dap.listeners.before.attach.dapui_config = function()
				vim.notify("Attaching to debugger")
			end

			dap.listeners.before.launch.dapui_config = function()
				vim.notify("Debugger attached")

				vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [t]oggle breakpoint" })
				vim.keymap.set("n", "<Leader>dT", function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end, { desc = "[D]debug [T]oggle log point" })

				vim.keymap.set("n", "<Leader>dj", dap.step_over, { desc = "[D]debug [j]step over" })
				vim.keymap.set("n", "<Leader>dh", dap.step_out, { desc = "[D]debug [h]step out" })
				vim.keymap.set("n", "<Leader>dl", dap.step_into, { desc = "[D]debug [l]step into" })

				vim.keymap.set("n", "<Leader>dk", function()
					require("dap.ui.widgets").hover()
				end, { desc = "[D]debug [k]hover" })

				vim.keymap.set("n", "<Leader>do", dapui.open, { desc = "[D]ebug UI [o]pen" })
				vim.keymap.set("n", "<Leader>dc", dapui.close, { desc = "[D]ebug UI [c]lose" })
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
	{
		-- Git diff view util
		"sindrets/diffview.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		cmd = "DiffviewOpen",
	},
	{ "norcalli/nvim-colorizer.lua" }
})
