-- Lazy.nvim notes:
-- > Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " " -- Leader key is space (instead of default \)
vim.g.maplocalleader = "," -- <LocalLeader>

-- Make .env its own filetype.
-- (it's mostly so i can disable copilot in .env files)
vim.cmd([[
  autocmd BufRead,BufNewFile *.env set filetype=env
  autocmd FileType env set syntax=sh
]])

require("main-settings")

-- bootstrap lazy.nvim plugin manager
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

-- TODO replace this setup with `import = "plugins"`?
-- example: https://dev.to/asyncedd/using-lazynvim-in-our-neovim-configuration-glg
require("lazy").setup({
	-- show possible key combos
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	-- Guide lines for indents
	-- :help indent_blankline.txt
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		name = "indent_blankline.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"catppuccin/nvim",
		},
		-- opts = {
		-- 	-- need to upgrade to v3 from v2
		-- 	-- https://github.com/lukas-reineke/indent-blankline.nvim/wiki/Migrate-to-version-3
		--
		-- 	-- char_highlight_list = {
		-- 	-- 	"IndentBlanklineIndent1",
		-- 	-- 	"IndentBlanklineIndent2",
		-- 	-- 	"IndentBlanklineIndent3",
		-- 	-- 	"IndentBlanklineIndent4",
		-- 	-- 	"IndentBlanklineIndent5",
		-- 	-- 	"IndentBlanklineIndent6",
		-- 	-- 	"IndentBlanklineIndent7",
		-- 	-- },
		-- 	-- space_char_highlight_list = {
		-- 	-- 	"IndentBlanklineIndent1",
		-- 	-- 	"IndentBlanklineIndent2",
		-- 	-- 	"IndentBlanklineIndent3",
		-- 	-- 	"IndentBlanklineIndent4",
		-- 	-- 	"IndentBlanklineIndent5",
		-- 	-- 	"IndentBlanklineIndent6",
		-- 	-- 	"IndentBlanklineIndent7",
		-- 	-- },
		-- 	-- --[[ space_char_blankline = " ", ]]
		-- 	-- show_current_context = true,
		-- 	-- show_current_context_start = true,
		-- 	-- show_end_of_line = false, -- hide EOL listchar on blanklines
		-- 	-- char = "┃",
		-- 	-- space_char_blankline = "·", -- prob only use if you set char
		-- 	-- char_blankline = "┊",
		-- 	-- context_char = "█",
		-- 	-- context_char_blankline = "║",
		-- },
		config = function()
			-- local colors = require("catppuccin.palettes").get_palette()
			-- TODO not sure how to re-use the highlights that i set elsewhere,
			-- so i'm just kind of re-declaring them here for now... hm.
			-- ^^^^ actually, it SEEMS like i don't need the hooks... but if indent highlighting breaks,
			-- i'll try using the hook. 
			local highlight = {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
				"IndentBlanklineIndent7",
			}
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			-- local hooks = require "ibl.hooks"
			-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent1", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent2", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent3", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent4", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent5", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent6", true))
			-- 	vim.api.nvim_set_hl(0, "IndentBlanklineIndent7", vim.api.nvim_get_hl_by_name("IndentBlanklineIndent7", true))
			-- end)

			-- sync with rainbow-delimiters
			vim.g.rainbow_delimiters = { highlight = highlight }

			local ibl = require("ibl")
			ibl.setup({
				indent = {
					char = "│",
					tab_char = "│", -- uses 'lcs-tab' by default if 'list' is set, otherwises uses 'ibl.config.indent.char'
					highlight = highlight, -- highlight group, or list of highligh groups
					-- in v3/2023-11-25, there is no equiv to "current context" from v2 afaict. so, TODO
				},
				scope = {
					-- NOTE: scope is not the current indentation level!
					-- Instead, it is the indentation level where variables
					-- or functions are accessible.

					-- enabled = false,

					-- include = {
					-- 	node_type = {
					-- 		lua = {
					-- 			'chunk',
					-- 			'do_statement',
					-- 			'while_statement',
					-- 			'repeat_statement',
					-- 			'if_statement',
					-- 			'for_statement',
					-- 			'function_declaration',
					-- 			'function_definition',
					-- 			'table_constructor',
					-- 			'assignment_statement',
					-- 		},
					-- 		typescript = {
					-- 			'statement_block',
					-- 			'function',
					-- 			'arrow_function',
					-- 			'function_declaration',
					-- 			'method_definition',
					-- 			'for_statement',
					-- 			'for_in_statement',
					-- 			'catch_clause',
					-- 			'object_pattern',
					-- 			'arguments',
					-- 			'switch_case',
					-- 			'switch_statement',
					-- 			'switch_default',
					-- 			'object',
					-- 			'object_type',
					-- 			'ternary_expression',
					-- 		},
					-- 	},
					-- },
				},
				-- vim.opt.listchars:append("space: "),
			})
		end
	},

	-- manage global and project-local settings
	{ "folke/neoconf.nvim", cmd = "Neoconf" },

	-- completion for nvim lua API
	{ "folke/neodev.nvim", name = "neodev" },
	-- TODO ^ what's the diff between this and nLUA via coq_3p ?

	-- theme: catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.g.catppuccin_flavour = "frappe" -- Has to be set in order for empty argument of get_palette to work?
		end,
		config = function()
			-- vim.g.catppuccin_flavour = "frappe" -- Has to be set in order for empty argument of get_palette to work
			-- used for some color tweaks later
			-- local catppuccin_flavour = require("catppuccin.palettes").get_palette() -- g:catppuccin_flavour's palette
			-- TODO ^ how the fuck do i get lsp autocompletion on this variable?

			local colors = require("catppuccin.palettes").get_palette()
			-- TODO ^ how the fuck do i get lsp autocompletion on this variable?

			-- print(vim.inspect(colors))
			-- print("fooooooo")

			require("catppuccin").setup({
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				transparent_background = true, -- or else some things (vague, i know) aren't transparent
				term_colors = true, -- TODO wtf this do? trying this
				compile = {
					enabled = true, -- true = faster startup
					path = vim.fn.stdpath("cache") .. "/catppuccin",
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					treesitter = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					lsp_trouble = false,
					cmp = true,
					lsp_saga = true,
					gitsigns = true,
					leap = false,
					telescope = true,
					dap = {
						enabled = false,
						enable_ui = false,
					},
					which_key = true,
					indent_blankline = {
						-- i set these colors manually elsewhere, without using these settings...
						-- which TODO makes me feel like i did it wrong since here we are
						enabled = false,
						colored_indent_levels = false,
					},
					hop = true,
					fidget = true,
					-- rainbow_delimiters = true, -- manually set to sync w/ indent-blankline, not sure this is necessary
				},
				color_overrides = {
					-- Related reading
					-- -> Catppuccin styleguide: https://github.com/catppuccin/catppuccin/blob/d7a1918a23fb28e912bfd721eedef0ff452db872/docs/style-guide.md

					-- TODO
					all = {
						-- the default rainbow is too red,
						-- i like this rainbow better:
						rainbow1 = colors.lavender,
						rainbow2 = colors.blue,
						rainbow3 = colors.teal,
						rainbow4 = colors.green,
						rainbow5 = colors.yellow,
						rainbow6 = colors.peach,
						rainbow7 = colors.pink,

						-- example
						--[[ 	text = "#ffffff", ]]
					},
					-- theme-specific tweaks
					--[[ latte = { ]]
					--[[ 	base = "#ff0000", ]]
					--[[ 	mantle = "#242424", ]]
					--[[ 	crust = "#474747", ]]
					--[[ }, ]]
				},
				--
				highlight_overrides = {
					-- TODO
					all = function(colors)
						return {
							-- alias catpuccin's `rainbowX` to indent_blankline's expected colors
							IndentBlanklineIndent1 = { fg = colors.rainbow1 },
							IndentBlanklineIndent1 = { fg = colors.rainbow1 },
							IndentBlanklineIndent1 = { fg = colors.rainbow1 },
							IndentBlanklineIndent2 = { fg = colors.rainbow2 },
							IndentBlanklineIndent3 = { fg = colors.rainbow3 },
							IndentBlanklineIndent4 = { fg = colors.rainbow4 },
							IndentBlanklineIndent5 = { fg = colors.rainbow5 },
							IndentBlanklineIndent6 = { fg = colors.rainbow6 },
							IndentBlanklineIndent7 = { fg = colors.rainbow7 },
							IblScope = { fg = colors.yellow, bg = colors.yellow },
							-- IndentBlanklineContextChar = { fg = "#ff0000", bg = "#ff0000" },
							--[[ IndentBlanklineContextStart = { ]]
							--[[ 	fg = "#ff0000", ]]
							--[[ 	bg = "#ff0000", ]]
							--[[ 	-- guisp = "#ff0000", ]]
							--[[ 	-- gui = "undercurl", ]]
							--[[ }, ]]

							-- Improved "go to definition" highlighting
							SagaBeacon = { bg = colors.yellow },

							-- the default greay isn't very visible
							CursorLine = { bg = colors.surface0 }, -- row highlight
							CursorColumn = { bg = colors.surface0 }, -- col highlight
							-- TODO styling Cursor doesn't seem to work for me. not sure why.
							--[[ Cursor = { ]]
							--[[ 	bg = catppuccin_flavour.yellow, ]]
							--[[ 	fg = catppuccin_flavour.surface3, ]]
							--[[ }, ]]

							-- fidget.nvim overrides
							FidgetTitle = {
								fg = colors.blue,
							},
							FidgetTask = {
								fg = colors.teal,
							},

							-- nvim-treesitter-context
							TreesitterContext = {
								bg = colors.surface0,
								blend = 20,
							},
						}
					end,
				},
				--
				-- --[[ custom_highlights = function(colors) ]]
				-- --[[ 	return { ]]
				-- --[[ 		-- Comment = { fg = colors.flamingo }, ]]
				-- --[[ 		-- TabLineSel = { bg = colors.pink }, ]]
				-- --[[ 		-- CmpBorder = { fg = colors.surface2 }, ]]
				-- --[[ 		-- Pmenu = { bg = colors.none }, ]]
				-- --[[]]
				-- --[[ 		-- TODO ]]
				-- --[[ 		-- IndentBlanklineContextChar = { fg = "#ff0000", bg = "#ff0000" }, ]]
				-- --[[ 		IndentBlanklineContextStart = { ]]
				-- --[[ 			fg = "#ff0000", ]]
				-- --[[ 			bg = "#ff0000", ]]
				-- --[[ 			-- guisp = "#ff0000", ]]
				-- --[[ 			-- gui = "undercurl", ]]
				-- --[[ 		}, ]]
				-- --[[ 	} ]]
				-- --[[ end, ]]
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Copilot AI assistant
	{
		"github/copilot.vim",
		name = "copilot",
		init = function()
			vim.g.copilot_filetypes = {
				-- defaults: https://github.com/github/copilot.vim/blob/1358e8e45ecedc53daf971924a0541ddf6224faf/autoload/copilot.vim#L131-L140
				env = false, -- ft=sh is what .env uses for syntax by defaeult
			}
		end,
	},
	-- TODO couldn't get copilot.lua working
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	name = "copilot.lua",
	-- 	enabled = true,
	-- 	lazy = false,
	-- 	event = { "InsertEnter" },
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = false,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<M-l>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 			filetypes = {
	-- 				-- typescript = true,
	-- 				markdown = false,
	-- 				env = false, -- ft=sh is what .env uses for syntax by default
	-- 				sh = function() -- ... for good measure
	-- 					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
	-- 						-- disable for .env files
	-- 						return false
	-- 					end
	-- 					return true
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- File browser
	{
		"scrooloose/nerdtree",
		name = "nerdtree",
		keys = {
			-- NERDTree in current buffer's directory
			{
				"<Leader>n", -- key map
				"<cmd>NERDTreeToggle %:p:h<CR>", -- command
				mode = "n",
				desc = "NERDTree % (cwd)",
			},
		},
	},

	-- Find, filter, preview, pick
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		cmd = { "Telescope" },
		name = "telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",

			-- fzf extension for telescope with better speed
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- after = "telescope.nvim",
				build = "make",
				init = function()
					-- TODO i'm loading extensions elsewhere too... DRY?
					require("telescope").load_extension("fzf")
				end,
			},

			-- nvim-telescope/telescope-ui-select.nvim
			-- 📺 A UI for the telescope fuzzy finder over lists (like code actions)
			{
				"nvim-telescope/telescope-ui-select.nvim",
				name = "telescope-ui-select.nvim",
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin") -- builtin pickers: https://github.com/nvim-telescope/telescope.nvim#pickers
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					dynamic_preview_title = true,
					mappings = {
						n = {
							["<c-d>"] = actions.delete_buffer,
						},
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						i = {
							['<ScrollWheelUp>'] = actions.preview_scrolling_up,
						},
						i = {
							['<ScrollWheelDown>'] = actions.preview_scrolling_down,
						},
					},
					theme = "dropdown",
					previewer = true,
					file_ignore_patterns = { "node_modules", "package-lock.json" },
					initial_mode = "insert",
					select_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.75,
						height = 0.75,
						prompt_position = "top",
						preview_cutoff = 120,
					},
					wrap_results = true,
					path_display = { "smart" },
					winblend = 20,
					border = {},
					borderchars = nil,
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" },

					-- Show full file paths
					-- find_command = { "fd", "-t=f", "-a" },
					-- path_display = { "absolute" },
					-- wrap_results = true,

					-- TODO it would be nice to have fzf too.
					vimgrep_arguments = {
						"rg", -- TODO: automate ripgrep install
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
				},

				pickers = {
					find_files = {
						hidden = true,
						previewer = false,
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					},
					git_files = {
						hidden = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.8,
								height = 0.8,
								preview_width = 0.5,
							},
						},
					},
					live_grep = {
						--@usage don't include the filename in the search results
						only_sort_text = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					grep_string = {
						--@usage don't include the filename in the search results
						only_sort_text = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					buffers = {
						-- initial_mode = "normal",
						sort_lastused = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.8,
								height = 0.8,
								preview_width = 0.5,
							},
						},
					},
					lsp_references = {
						show_line = false,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					treesitter = {
						show_line = true, -- TODO temporarily enabled to try it? not sure what it does, just saw as i scrolled.
						sorting_strategy = nil,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
						symbols = {
							"class",
							"function",
							"method",
							"interface",
							"type",
							"const",
							"variable",
							"property",
							"constructor",
							"module",
							"struct",
							"trait",
							"field",
						},
					},
				},

				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},

					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							previewer = false,
							initial_mode = "normal",
							sorting_strategy = "ascending",
							layout_strategy = "horizontal",
							layout_config = {
								horizontal = {
									width = 0.6,
									height = 0.6,
									preview_width = 0.6,
								},
							},
						}),
					},
				},
			})

			-- Note: fzf extension is loaded in init for whatever reason.
			telescope.load_extension("ui-select")

			-- TODO move keymaps below to lazy's `keys` ?
			-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			--[[ vim.keymap.set('n', '<leader>f', builtin.find_files(), {}) ]]
			--[[ vim.keymap.set('n', '<leader>f', function() builtin.find_files() end, {}) ]]
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.git_files({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "Find files",
			})
			--[[ vim.keymap.set('n', '<leader>f', function() builtin.find_files(find_files_opts) end, {}) ]]
			-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			-- vim.keymap.set('n', ';', builtin.buffers, {})
			vim.keymap.set("n", ";", function()
				builtin.buffers()
			end, {
				silent = true,
				desc = "Find buffer",
			})

			vim.keymap.set("n", "<leader>Ds", function()
				builtin.lsp_document_symbols({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "Document symbols",
			})

			-- lol i guess it makes sense.
			vim.keymap.set("n", "<leader>Dp", function()
				builtin.planets({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "Planets",
			})

			-- requires ripgrep installed
			vim.keymap.set("n", "<leader>G", function()
				builtin.live_grep({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "grep (live)",
			})

			vim.keymap.set("n", "<leader>g", function()
				builtin.grep_string({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "grep (string)",
			})

			vim.keymap.set("n", "<leader>Db", function()
				builtin.builtin({
					path_display = { "absolute" },
				})
			end, {
				silent = true,
				desc = "Builtins",
			})
		end,

		-- TODO use `keys = {...}` instead of fn#config?
		-- per https://www.reddit.com/r/neovim/comments/1039iti/minimal_config_with_lazy_treesitter_lspzero/
	},

	-- Treesitter - fancier highlighting, mostly.
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		run = ":TSUpdate",
		dependencies = {
			{
				"numToStr/Comment.nvim",
				name = "Comment.nvim",
				dependencies = {
					"JoosepAlviste/nvim-ts-context-commentstring",
				},
				config = function()
					-- Note: 'opts' does not work here because of the pre_hook for ts_context_commentstring
					-- Unclear why ^ that is the case, but here we are.
					require("Comment").setup({
						pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

						---Add a space b/w comment and the line
						---@type boolean|fun():boolean
						padding = true,

						---Whether the cursor should stay at its position
						---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
						---@type boolean
						sticky = true,

						---Lines to be ignored while comment/uncomment.
						---Could be a regex string or a function that returns a regex string.
						---Example: Use '^$' to ignore empty lines
						---@type string|fun():string
						ignore = nil,

						---LHS of toggle mappings in NORMAL + VISUAL mode
						---@type table
						toggler = {
							---Line-comment toggle keymap
							line = "gcc",
							---Block-comment toggle keymap
							block = "gbc",
						},

						---LHS of operator-pending mappings in NORMAL + VISUAL mode
						---@type table
						opleader = {
							---Line-comment keymap
							line = "gc",
							---Block-comment keymap
							block = "gb",
						},

						---LHS of extra mappings
						---@type table
						extra = {
							---Add comment on the line above
							above = "gcO",
							---Add comment on the line below
							below = "gco",
							---Add comment at the end of line
							eol = "gcA",
						},

						---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
						---NOTE: If `mappings = false` then the plugin won't create any mappings
						---@type boolean|table
						mappings = {
							---Operator-pending mapping
							---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
							---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
							basic = true,
							---Extra mapping
							---Includes `gco`, `gcO`, `gcA`
							extra = true,
							---Extended mapping
							---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
							extended = false,
						},
					})
				end,
			},

			-- Treesitter-based context as you scroll through code
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					-- separator = "░", -- Separator between context and content. Should be a single character string, like '-'.
					max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
					trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					patterns = {
						-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
						-- For all filetypes
						-- Note that setting an entry here replaces all other patterns for this entry.
						-- By setting the 'default' entry below, you can control which nodes you want to
						-- appear in the context window.
						default = {
							"class",
							"function",
							"method",
							"for",
							"while",
							"if",
							"switch",
							"case",
						},
						-- Example for a specific filetype.
						-- If a pattern is missing, *open a PR* so everyone can benefit.
						--   rust = {
						--       'impl_item',
						--   },
					},
					exact_patterns = {
						-- Example for a specific filetype with Lua patterns
						-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
						-- exactly match "impl_item" only)
						-- rust = true,
					},

					-- [!] The options below are exposed but shouldn't require your attention,
					--     you can safely ignore them.

					zindex = 20, -- The Z-index of the context window
					mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				},
				keys = {
					{
						"]c", -- key map
						"<cmd>lua require('treesitter-context').go_to_context() <cr>", -- cmd
						mode = "n",
						desc = "Go to context",
					},
				},
			},

			-- Treesitter-based contextual comments (eg do {/* these */} in jsx depending on cursor location)
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				dependencies = {
					-- "nvim-treesitter/nvim-treesitter",
					-- "numToStr/Comment.nvim",
				},
				init = function()
					vim.g.skip_ts_context_commentstring_module = true
				end,
				config = function()
					require("nvim-treesitter.configs").setup({
						ensure_installed = {
							"css",
							"graphql",
							"html",
							"javascript",
							"lua",
							"python",
							"scss",
							"tsx",
							"typescript",
							"vim",
						},

						-- @ DEPRECATED - Set vim.g.skip_ts_context_commentstring_module = true somewhere in your configuration to skip backwards compatibility routines and speed up loading.
						context_commentstring = {
							enable = false,
						},

						-- Incremental selection based on the named nodes from the grammar.
						incremental_selection = {
							enable = true,
							keymaps = {
								init_selection = "gnn", -- set to `false` to disable one of the mappings
								node_incremental = "grn",
								scope_incremental = "grc",
								node_decremental = "grm",
								init_selection = "<Enter>",
								node_incremental = "<Enter>",
								node_decremental = "<BS>",
							},
						},

						-- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
						indent = {
							enable = true,
						},

						highlight = {
							enable = true,
							disable = { "" }, -- list of language that will be disabled
							-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
							-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
							-- Using this option may slow down your editor, and you may see some duplicate highlights.
							-- Instead of true it can also be a list of languages
							additional_vim_regex_highlighting = true,
						},
					})
				end,
			},

			-- Treesitter-based autoclose and autorename HTML tags
			-- {
			-- 	"windwp/nvim-ts-autotag",
			-- 	config = function()
			-- 		require("nvim-treesitter.configs").setup({ autotag = { enable = true } })
			-- 	end,
			-- },

			-- Autopair
			-- {
			-- 	"windwp/nvim-autopairs",
			-- 	opts = {
			-- 		check_ts = true,
			-- 	},
			-- },

			-- Syntax aware text-objects, select, move, swap, and peek support
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},

			-- Highlight function arguments
			{
				"m-demare/hlargs.nvim",
			},

			-- Treesitter-based local code dimming
			{
				"folke/twilight.nvim",
				opts = {
					-- https://github.com/folke/twilight.nvim#%EF%B8%8F-configuration
					--
					treesitter = true,
				},
			},
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"typescript",
					"tsx",
					"javascript",
					"json",
					"json5",
					"css",
					"html",
					"markdown",
					"markdown_inline",
					"yaml",
					"regex",
					"lua",
					"vim",
				},

				highlight = {
					enable = true,
					disable = { "" }, -- list of language that will be disabled
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = true,
				},

				-- nvim-ts-context-commentstring stuff
				-- NOTE: some config in Comment.nvim relevant as well;
				-- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim=
				context_commentstring = {
					enable = true,
					enable_autocmd = false, -- for Comment.nvim, per https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
				},

				-- nvim-treesitter-textobjects config
				-- mostly lets me jump around using treesitter awareness
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
						-- You can choose the select mode (default is charwise 'v')
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding xor succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						include_surrounding_whitespace = true,
					},

					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},

					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},

				-- Incremental selection based on the named nodes from the grammar.
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- set to `false` to disable one of the mappings
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
						init_selection = "<Enter>",
						node_incremental = "<Enter>",
						node_decremental = "<BS>",
					},
				},

				-- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- Substitute variants (like case differences),
	-- eg: :%s/foo/bar/g
	-- eg: (visual selection) Subvert/foo/bar/g
	-- ... would replace all foo/Foo/FOO with bar/Bar/BAR
	-- It can do a lot more though, but that's 99% of what i do with it.
	-- TODO learn more stuff that it can do — https://github.com/tpope/vim-abolish
	{
		"tpope/vim-abolish",
	},

	-- Git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns.nvim",
		lazy = false, -- show signs asap
		opts = {
			signs = {
				add = { text = "🌱" }, -- sprout symbolizes something new (added line)
				change = { text = "🌀" }, -- cyclone as things are changing
				delete = { text = "🔥" }, -- fire as the line has been deleted
				topdelete = { text = "💥" }, -- collision symbolizing the start of a deletion
				changedelete = { text = "🌪" }, -- tornado, as the change has been deleted
				untracked = { text = "👣" }, -- footprints, as these are untracked changes
			},
		},
		keys = {
			{
				"]h", -- key map
				"<cmd>lua require('gitsigns').next_hunk()<cr>", -- cmd
				mode = "n",
				desc = "Next hunk",
			},
			{
				"[h", -- key map
				"<cmd>lua require('gitsigns').prev_hunk()<cr>", -- cmd
				mode = "n",
				desc = "Previous hunk",
			},
		},
	},

	-- Jump anywhere in the file.
	{
		"phaazon/hop.nvim",
		name = "hop.nvim",
		branch = "v2", -- optional but strongly recommended
		keys = {
			{
				"gw", -- key map
				nil, -- for LazyKey, use nil + assign via vim.api.nvim_set_keymap in config()
				mode = "n",
				desc = "Hop word",
			},
		},
		config = function()
			require("hop").setup({
				keys = "wasdfjk", -- only prompt for these characters
			})
			vim.api.nvim_set_keymap(
				"n", -- mode
				"gw", -- key map
				'<cmd>lua require("hop").hint_words()<cr>', -- cmd
				{}
			)
		end,
		-- TODO replace default movements with hop
		-- eg -> https://github.com/phaazon/hop.nvim/wiki/Advanced-Hop#building-advanced-hop-motions
		-- eg -> https://dev.to/kquirapas/neovim-on-steroids-vim-sneak-easymotion-hopnvim-4k17
	},

	-- not sure if i need this here since other
	-- plugins just use it as a dependency?
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		name = "null-ls",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		-- TODO automate this install
		-- npm install -g @fsouza/prettierd
		-- TODO maybe using mason.nvim ? or something?

		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local code_actions = null_ls.builtins.code_actions
			-- local typescript_code_actions = require("typescript.extensions.null-ls.code-actions")
			-- local diagnostics = null_ls.builtins.diagnostics
			-- local completion = null_ls.builtins.completion

			-- TODO Try this suggestion for eslint_d + buf formatting
			-- https://github.com/jose-elias-alvarez/typescript.nvim/issues/57#issuecomment-1387148837

			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),

				sources = {
					formatting.stylua, -- TODO auto install stylua
					-- typescript_code_actions, -- typescript.nvim
					code_actions.gitsigns, -- provide code actions from Gitsigns
					formatting.prettierd,
					-- formatting.prettier_eslint, -- TODO investigate this
				},
				on_attach = function(client)
					-- Auto-format on save if document has formatter(s)
					-- if client.server_capabilities.documentFormattingProvider then
					-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 4000 })")
					-- end
				end,
			}
		end,
	},

	-- TODO maybe use a statusline instead?
	{
		"j-hui/fidget.nvim",
		name = "fidget.nvim",
		tag = "legacy",
		lazy = false,
		opts = {
			sources = {
				-- mostly used for formatting and such
				["null-ls"] = {
					ignore = true,
				},
			},
			-- https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget.md
			text = {
				-- animation shown when tasks are ongoing
				-- Premade spinners @ https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget.md#spinners
				spinner = require("custom-fidgets").bouncing_satellite,
				done = "🚀", -- character shown when all tasks are complete
				commenced = "Started", -- message shown when task starts
				completed = "Completed", -- message shown when task completes
			},

			window = {
				-- NOTE: changing this from 0 only makes it black. Not sure why.
				blend = 0,
			},

			time = {
				fidget_decay = 1000,
			},
		},
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- auto-expand splits
	{
		"nvim-focus/focus.nvim",
		lazy = false,
		config = function()
			require("focus").setup({
				enable = true, -- Enable module
				commands = true, -- Create Focus commands
				autoresize = {
					enable = false, -- Enable or disable auto-resizing of splits
					width = 0, -- Force width for the focused window
					height = 0, -- Force height for the focused window
					minwidth = 0, -- Force minimum width for the unfocused window
					minheight = 0, -- Force minimum height for the unfocused window
					height_quickfix = 10, -- Set the height of quickfix panel
				},
				split = {
					bufnew = false, -- Create blank buffer for new split windows
					tmux = false, -- Create tmux splits instead of neovim splits
				},
				ui = {
					number = false, -- Display line numbers in the focussed window only
					relativenumber = false, -- Display relative line numbers in the focussed window only
					hybridnumber = false, -- Display hybrid line numbers in the focussed window only
					absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

					cursorline = false, -- Display a cursorline in the focussed window only
					cursorcolumn = true, -- Display cursorcolumn in the focussed window only
					colorcolumn = {
						enable = false, -- Display colorcolumn in the foccused window only
						list = "+1", -- Set the comma-saperated list for the colorcolumn
					},
					signcolumn = true, -- Display signcolumn in the focussed window only
					winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
				},
			})
		end,
		keys = {
			-- NERDTree in current buffer's directory
			{
				"<c-l>", -- key map
				"<cmd>FocusSplitNicely<CR>", -- command
				mode = "n",
				desc = "Split nicely (golden ratio)",
			},
		},
	},

	-- TODO compare to https://github.com/Pocco81/true-zen.nvim
	{
		"folke/zen-mode.nvim",
		opts = {
			-- https://github.com/folke/zen-mode.nvim#%EF%B8%8F-configuration
			kitty = {
				enabled = true,
				font = "+4", -- font size increment
			},
		},
	},

	-- TODO prisma support ?
	{
		"prisma/vim-prisma",
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		enable = true,
		-- lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("typescript-tools").setup({
				settings = {
					-- spawn additional tsserver instance to calculate diagnostics on it
					separate_diagnostic_server = true,
					-- "change"|"insert_leave" determine when the client asks the server about diagnostic
					publish_diagnostic_on = "insert_leave",
					-- to include all supported code actions specify commands exposed as code_actions
					-- expose_as_code_action = "all",
					expose_as_code_action = {
						"fix_all",
						"add_missing_imports",
						"remove_unused",
						"remove_unused_imports",
						"organize_imports",
					},
					-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
					-- not exists then standard path resolution strategy is applied
					tsserver_path = nil,
					-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
					-- (see 💅 `styled-components` support section)
					tsserver_plugins = {},
					-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
					-- memory limit in megabytes or "auto"(basically no limit)
					tsserver_max_memory = "auto",
					-- described below
					tsserver_format_options = {},
					tsserver_file_preferences = {},
					-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
					complete_function_calls = false,

					-- Note that handlers can be used to override certain LSP methods.
					-- For example, you can use the filter_diagnostics helper to ignore specific errors:
					-- handlers = {
					-- 	["textDocument/publishDiagnostics"] = api.filter_diagnostics(
					-- 	-- Ignore 'This may be converted to an async function' diagnostics.
					-- 	{ 80006 }
					-- 	),
					-- },

					-- tsserver_file_preferences = {
					-- 	includeInlayParameterNameHints = "all",
					-- 	includeCompletionsForModuleExports = true,
					-- 	quotePreference = "auto",
					-- 	-- ...,
					-- },
					-- tsserver_format_options = {
					-- 	allowIncompleteCompletions = false,
					-- 	allowRenameOfImportPath = false,
					-- 	-- ...,
					-- },
				},
			})
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		name = "nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },

			-- Snippets
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",

			-- Random completion sources
			-- DONT FORGET TO ADD THEM TO sources IN config() BELOW
			"hrsh7th/cmp-emoji", -- :shortcodes: -> emoji
			"jcha0713/cmp-tw2css", -- tailwind shorthand -> expanded css
			-- "hrsh7th/cmp-copilot", -- copilot.vim
			"hrsh7th/cmp-nvim-lsp-signature-help", -- show function signature
			-- "zbirenbaum/copilot.lua", -- copilot.lua
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				-- enabled = true,
				-- preselect = cmp.PreselectMode.None, -- prevent <Enter> from selecting choice without menu interaction

				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("snippy").expand_snippet(args.body) -- For `snippy` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "emoji" },
					{ name = "cmp-tw2css" },
					-- { name = "copilot" },
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer" },
				}),

				mapping = cmp.mapping.preset.insert({
					-- default uses up / down when the completion menu is open
					-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
					-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					-- ['<C-e>'] = cmp.mapping.abort(),

					-- Accept currently selected item.
					["<CR>"] = cmp.mapping.confirm({
						select = false, -- Set `select` to `false` to only confirm explicitly selected items.
					}),
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						-- before = function (entry, vim_item)
						--   ...
						--   return vim_item
						-- end

						-- symbol_map = {
						-- 	Boolean = "[] Boolean",
						-- 	Character = "[] Character",
						-- 	Class = "[] Class",
						-- 	Color = "[] Color",
						-- 	Constant = "[] Constant",
						-- 	Constructor = "[] Constructor",
						-- 	Enum = "[] Enum",
						-- 	EnumMember = "[] EnumMember",
						-- 	Event = "[ﳅ] Event",
						-- 	Field = "[] Field",
						-- 	File = "[] File",
						-- 	Folder = "[ﱮ] Folder",
						-- 	Function = "[󰊕] Function",
						-- 	Interface = "[] Interface",
						-- 	Keyword = "[] Keyword",
						-- 	Method = "[] Method",
						-- 	Module = "[] Module",
						-- 	Number = "[] Number",
						-- 	Operator = "[Ψ] Operator",
						-- 	Parameter = "[] Parameter",
						-- 	Property = "[] Property",
						-- 	Reference = "[] Reference",
						-- 	Snippet = "[] Snippet",
						-- 	String = "[] String",
						-- 	Struct = "[ﯟ] Struct",
						-- 	Text = "[] Text",
						-- 	TypeParameter = "[] TypeParameter",
						-- 	Unit = "[] Unit",
						-- 	Value = "[] Value",
						-- 	Variable = "[󰫧] Variable",
						-- 	Copilot = "[]",
						-- },

						-- let's try something weird
						symbol_map = {
							Boolean = "👍🏻 Boolean",
							Character = "🔤 Character",
							Class = "🎓 Class",
							Color = "🌈 Color",
							Constant = "🔒 Constant",
							Constructor = "🛠 Constructor",
							Enum = "🔢 Enum",
							EnumMember = "🔠 EnumMember",
							Event = "🔔 Event",
							Field = "🌱 Field",
							File = "📄 File",
							Folder = "📁 Folder",
							Function = "🔨 Function",
							Interface = "🔗 Interface",
							Keyword = "🔑 Keyword",
							Method = "🔎 Method",
							Module = "📦 Module",
							Number = "💯 Number",
							Operator = "➕➖ Operator",
							Parameter = "📝 Parameter",
							Property = "🔐 Property",
							Reference = "📚 Reference",
							Snippet = "✂️ Snippet",
							String = "💬 String",
							Struct = "🏗 Struct",
							Text = "📖 Text",
							TypeParameter = "📏 TypeParameter",
							Unit = "📏 Unit",
							Value = "💰 Value",
							Variable = "🔀 Variable",
							Copilot = "✈️ Copilot",
						},
					}),
				},
			})
		end,
	},
	-- { "hrsh7th/cmp-nvim-lsp" },

	-- LSP (Language Server Protocol) integration
	-- TODO push some of this to individual ftplugin files?
	-- TODO how do i install stuff so i dont have to do `npm install -g typescript-language-server` or whatever?
	-- TODO maybe using mason.nvim ? or something?
	-- NOTE: dont use typescript-language-server wtih typescript-tools.nvim
	{
		"neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
		dependencies = {
			-- LSP server for Lua
			"sumneko/lua-language-server",

			-- " Fancy lines for LSP messages
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		config = function()
			-- LSP configuration
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

			local lsp = require("lspconfig")

			-- Set up lspconfig.
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require("lspconfig")["typescript"].setup({
			-- 	capabilities = capabilities,
			-- })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- lsp["tsserver"].setup({}) -- DONT enable if using typescript-tools.nvim

			-- npm i -g vscode-langservers-extracted
			lsp["html"].setup({
				capabilities = capabilities,
			})
			-- npm i -g vscode-langservers-extracted
			lsp["cssls"].setup({
				capabilities = capabilities,
			})
			-- npm i -g vscode-langservers-extracted
			lsp["eslint"].setup({
				capabilities = capabilities,
				settings = {
					packageManager = "yarn",
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
			-- npm i -g vscode-langservers-extracted
			lsp["jsonls"].setup({
				capabilities = capabilities,
			})
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prismals
			-- npm install -g @prisma/language-server
			lsp["prismals"].setup({
				capabilities = capabilities,
			})
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
			-- npm install -g @tailwindcss/language-server
			lsp["tailwindcss"].setup({
				capabilities = capabilities,
			})

			-- TODO: WIP: Format config
			-- TODO: use eslint language server for better experience than null-ls' builtin eslint
			-- lsp.eslint.setup({
			-- 	settings = {
			-- 		packageManager = "yarn",
			-- 	},
			-- 	on_attach = function(client, bufnr)
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			buffer = bufnr,
			-- 			command = "EslintFixAll",
			-- 		})
			-- 	end,
			-- })

			-- Format keymap
			vim.keymap.set("n", "<leader>F", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", {
				desc = "LSP: format",
				silent = true,
			})

			-- lsp_lines config
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
				-- update_in_insert = true, -- aggressively real-time updates while in insert mode
			}) -- disable regular virtual text diagnostic
			vim.keymap.set("", "<Leader>l", "<cmd>lua require('lsp_lines').toggle()<CR>", { desc = "Toggle lsp_lines" })
			--[[ -- hide diagnostics on entering Insert mode ]]
			--[[ vim.api.nvim_create_autocmd('InsertEnter', { ]]
			--[[ 	callback = function() ]]
			--[[ 			vim.diagnostic.hide() ]]
			--[[ 	end, ]]
			--[[ }) ]]
			--[[ -- show diagnostics when exiting Insert mode ]]
			--[[ vim.api.nvim_create_autocmd('ModeChanged', { ]]
			--[[ 	pattern = 'i:*', ]]
			--[[ 	callback = function() ]]
			--[[ 			vim.diagnostic.show() ]]
			--[[ 	end, ]]
			--[[ }) ]]

			-- ESLint fix all in buffer
			vim.keymap.set("n", "<leader>L", "<cmd>EslintFixAll<CR>", {
				silent = true,
				desc = "LSP: Lint auto-fix buffer",
			})
		end,
	},

	-- Lspsaga for improving LSP UI/UX (vague, i know)
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional; -- Please make sure you install markdown and markdown_inline parser
			"nvim-tree/nvim-web-devicons", -- optional
		},
		-- 	event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				ui = {
					-- This option only works in Neovim 0.9
					title = true,
					-- Border type can be single, double, rounded, solid, shadow.
					border = "single",
					winblend = 20,
					expand = "",
					collapse = "",
					code_action = "💡",
					incoming = "",
					outgoing = "",
					hover = " ",
					-- kind = {}, -- defined in https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/lspkind.lua
				},

				-- may not *actually* be a lightbulb, that's just whawt the setting is called
				-- lightbulb = {
				-- 	enable = true,
				-- 	enable_in_insert = true,
				-- 	sign = true,
				-- 	sign_priority = 40,
				-- 	virtual_text = false, -- for some reason, it's enabled in both the signcol AND virtualtext by default
				-- },
			})
		end,
		keys = {
			-- Most borrowed from the example config:
			-- https://github.com/nvimdev/lspsaga.nvim#example-configuration
			-- TODO add more mappings from example config?

			-- Hover docs
			{
				"K", -- key map
				"<cmd>Lspsaga hover_doc<CR>", -- command
				mode = "n",
				desc = "Hover docs",
			},

			-- Finder (see definition, references)
			{
				"gh", -- key map
				"<cmd>Lspsaga finder<CR>", -- command
				mode = "n",
				desc = "Finder (definitions, refs)",
			},

			-- Code actions
			-- {
			-- 	"<leader>ca", -- key map
			-- 	-- use Lspsaga for code actions
			-- 	"<cmd>Lspsaga code_action<CR>", -- command
			-- 	mode = "n",
			-- 	desc = "Code actions",
			-- },
			{
				"<leader>ca", -- key map
				-- use native LSP's vim.ui.select for code actions
				"<cmd>lua vim.lsp.buf.code_action()<CR>", -- command
				mode = "n",
				desc = "Code actions 🔭",
			},

			-- Rename symbol/variable
			{
				"<leader>rn", -- key map
				"<cmd>Lspsaga rename<CR>", -- command
				mode = "n",
				desc = "Rename symbol/variable",
			},

			-- Peek definition
			{
				"gp", -- key map
				"<cmd>Lspsaga preview_definition<CR>", -- command
				mode = "n",
				desc = "Peek definition",
			},

			-- Go to definition
			{
				"gdd", -- key map
				"<cmd>Lspsaga goto_definition<CR>", -- command
				mode = "n",
				desc = "Go to definition",
			},

			-- Go to definition in vsplit
			{
				"gdv", -- key map
				-- Note that this opens in a split.. TODO do this with <mod> per https://github.com/prabirshrestha/vim-lsp/issues/169#issuecomment-619449593
				"<cmd>vsplit<cr><cmd>Lspsaga goto_definition<CR>", -- command
				mode = "n",
				desc = "Go to definition vsplit",
			},

			-- Go to definition in split
			{
				"gds", -- key map
				-- Note that this opens in a split.. TODO do this with <mod> per ^^^
				"<cmd>split<cr><cmd>Lspsaga goto_definition<CR>", -- command
				mode = "n",
				desc = "Go to definition hsplit",
			},

			-- Show line diagnostics
			{
				"<leader>cd", -- key map
				"<cmd>Lspsaga show_line_diagnostics<CR>", -- command
				mode = "n",
				desc = "Show line diagnostics",
			},

			-- Diagnostic jump
			-- You can use <C-o> to jump back to your previous location
			{
				"[e", -- key map
				"<cmd>Lspsaga diagnostic_jump_prev<CR>", -- command
				mode = "n",
				desc = "Diagnostic jump prev",
			},
			{
				"]e", -- key map
				"<cmd>Lspsaga diagnostic_jump_next<CR>", -- command
				mode = "n",
				desc = "Diagnostic jump next",
			},
		},
	},

	-- Displays the type-checking results in a quickfix list and provides visual notifications about the progress and completion of type-checking
	{
		"dmmulroy/tsc.nvim",
		name = "tsc.nvim",
		opts = {
			-- auto_open_qflist = true,
			-- auto_close_qflist = false,
			-- bin_path = utils.find_tsc_bin(),
			-- enable_progress_notifications = true,
			-- flags = {
			-- 	noEmit = true,
			-- 	project = function()
			-- 		return utils.find_nearest_tsconfig()
			-- 	end,
			-- },
			-- hide_progress_notifications_from_history = true,
			-- spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
		},
	},

	-- Deactivates the hlsearch when you move the cursor
	{
		"asiryk/auto-hlsearch.nvim",
		opts = {
			-- Defaults
			-- remap_keys = { "/", "?", "*", "#", "n", "N" },
			-- create_commands = true,
			-- pre_hook = function() end,
			-- post_hook = function() end,
		},
	},

	-- Rainbow parens n shit
	{
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		name = "rainbow-delimiters",
	},
}, {
	-- 	https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
	--
	-- Default lockfile location:
	-- lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	-- instead, we store it in the repo @ ~/Projects/dotfiles/nvim
	lockfile = "~/Projects/dotfiles/nvim/lazy-lock.json",
	-- TODO ^ not ideal that this seems to be how this works.
	-- I could probably use symlinking or something to avoid this?
})

-- Misc color tweaks after colorscheme is set
-- Transparent background (use terminal emulator opacity)
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
-- Floating window stuff
vim.cmd("highlight FloatBorder guifg=white")
vim.cmd("highlight NormalFloat guibg=black")
-- Tweak incline.nvim colors
vim.cmd("highlight InclineNormal guifg=#363A4F guibg=#C6A0F6 gui=bold")
vim.cmd("highlight InclineNormalNC guifg=#737994 guibg=#414559 gui=reverse")

-- 1 statusline per neovim instance
vim.opt.laststatus = 3

-- Make filetypes of PostCSS = CSS
vim.cmd("autocmd BufEnter *.pcss :setlocal filetype=css")

-- Customize LSP diagnostic displays (gutter sign, highlight group, etc)
vim.fn.sign_define("DiagnosticSignError", {
	text = "🔺", -- red triangle pointing up for errors
	texthl = "TextError",
	linehl = "TSDanger",
	numhl = "TSDanger",
})
vim.fn.sign_define("DiagnosticSignWarn", {
	text = "⚠️", -- warning sign for warnings
	texthl = "TextWarn",
	linehl = "TSWarning",
	numhl = "TSWarning",
})
vim.fn.sign_define("DiagnosticSignInfo", {
	text = "ℹ️", -- lightbulb for information
	texthl = "TextInfo",
	linehl = "TSNote",
	numhl = "TSNote",
})
vim.fn.sign_define("DiagnosticSignHint", {
	text = "🔍", -- magnifying glass for hints
	texthl = "TextHint",
	linehl = "TSNote",
	numhl = "TSNote",
})

-- TODO how to get strikethrough on @deprecated in tsx/jsdocs?
