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
vim.keymap.set("n", "<Leader>s", ":%s//g<Left><Left>", { desc = "[s]ed command" })
vim.keymap.set("n", "<Leader>h", ':exe "vertical resize -" .5<CR>', { desc = "-5 on vertical split" })
vim.keymap.set("n", "<Leader>l", ':exe "vertical resize +" .5<CR>', { desc = "+5 on vertical split" })
vim.keymap.set("n", "<Leader>j", ':exe "resize -" .5<CR>', { desc = "-5 on horizontal split" })
vim.keymap.set("n", "<Leader>k", ':exe "resize +" .5<CR>', { desc = "+5 on horizontal split" })
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [n]ew" })
vim.keymap.set("n", "<Leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab close [x]" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set({ "v", "n" }, "<leader>f", "<cmd>Format<CR> ", { desc = { "[f]ormat buffer" } })
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
		end,
	},
	{
		-- Tree explorer like a buffer
		"stevearc/oil.nvim",
		config = function()
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
					show_hidden = true,
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
				javascript = { { "prettierd", "prettier" } },
				astro = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },

				-- C Sharpier can be installed with dotnet
				-- $ dotnet tool install csharpier -g
				-- see: https://github.com/belav/csharpier
				csharp = { { "csharpier" } },

				-- Gofmt should be included with your go installation, make sure "go/bin" is in your path
				go = { { "gofmt" } },

				-- Rustfmt  can be installed it with rustup
				-- $ rustup component add rustfmt
				-- see: https://github.com/rust-lang/rustfmt?tab=readme-ov-file#quick-start
				rust = { { "rustfmt" } },
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

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
				vim.notify("Harpoon mark added")
			end, { desc = "[h]arpoon [a]ppend mark" })
			vim.keymap.set("n", "<leader>h}", function()
				harpoon:list():next()
			end, { desc = "[h]arpoon } next mark" })
			vim.keymap.set("n", "<leader>h{", function()
				harpoon:list():prev()
			end, { desc = "[h]arpoon { prev mark" })
			vim.keymap.set("n", "<leader>hc", function()
				harpoon:list():clear()
				vim.notify("Harpoon marks cleared")
			end, { desc = "[h]arpoon [c]lean marks" })
			vim.keymap.set("n", "<leader>sm", function()
				toggle_telescope(harpoon:list())
			end, { desc = "[s]earch harpoon [m]arks" })
		end,
	},
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			-- require("which-key").register({
			-- 	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- 	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			-- 	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			-- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- 	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			-- })
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
		-- Theme
		"folke/tokyonight.nvim",
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
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local treesiter = require("nvim-treesitter.configs")
			treesiter.setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
					indent = { enable = true },
				},
			})
		end,
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]parenthen
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
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
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					vim.notify("LSP client attached")
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
				capabilities = capabilities,
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
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			-- Available through npm
			-- $ npm install -g typescript typescript-language-server
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			-- Available through npm
			-- $ npm i -g vscode-langservers-extracted
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			-- Available through npm
			-- $ npm install -g @astrojs/language-server
			lspconfig.astro.setup({
				capabilities = capabilities,
			})
			-- Mostly available through package managers.
			-- see: https://luals.github.io/#neovim-install
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			-- see: https://github.com/razzmatazz/csharp-language-server
			-- $ dotnet tool install --global csharp-ls
			local pid = vim.fn.getpid()
			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				handlers = {
					["textDocument/definition"] = require("csharpls_extended").handler,
					["textDocument/typeDefinition"] = require("csharpls_extended").handler,
				},
			})
			-- Available through your package manager or see the pre-built binaries
			-- see: https://github.com/artempyanykh/marksman/blob/main/docs/install.md
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<Leader>d<Space>", dap.continue, { desc = "[D]ebug launch/continue" })

			-- NOTE: See all available DAP adapters here: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			dap.adapters.coreclr = {
				type = "executable",
				command = "/usr/local/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				vim.keymap.set("i", "<Leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [t]oggle breakpoint" })
				vim.keymap.set("i", "<Leader>dT", function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end, { desc = "[D]debug [T]oggle log point" })

				vim.keymap.set("n", "<Leader>dj", dap.step_over, { desc = "[D]debug [j]step over" })
				vim.keymap.set("n", "<Leader>dh", dap.step_out, { desc = "[D]debug [h]step out" })
				vim.keymap.set("n", "<Leader>dl", dap.step_into, { desc = "[D]debug [l]step into" })

				vim.keymap.set("n", "<Leader>dk", function()
					require("dap.ui.widgets").hover()
				end, { desc = "[D]debug [k]hover" })

				vim.keymap.set("n", "<Leader>do", dapui.open, { desc = "[D]ebug UI [o]pen" })
				vim.keymap.set("<Leader>dc", dapui.close, { desc = "[D]ebug UI [c]lose" })
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
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
})
