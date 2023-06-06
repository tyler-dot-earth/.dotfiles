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

vim.g.copilot_filetypes = {
	-- defaults: https://github.com/github/copilot.vim/blob/1358e8e45ecedc53daf971924a0541ddf6224faf/autoload/copilot.vim#L131-L140
	env = false, -- ft=sh is what .env uses for syntax by defaeult
}

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
		name = "indent_blankline.nvim",
		opts = {
			char_highlight_list = {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
				"IndentBlanklineIndent7",
			},
			space_char_highlight_list = {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
				"IndentBlanklineIndent7",
			},
			--[[ space_char_blankline = " ", ]]
			show_current_context = true,
			show_current_context_start = true,
			show_end_of_line = false, -- hide EOL listchar on blanklines
			char = "┃",
			space_char_blankline = "·", -- prob only use if you set char
			char_blankline = "┊",
			context_char = "█",
			context_char_blankline = "║",
		},
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
		config = function()
			vim.g.catppuccin_flavour = "frappe" -- Has to be set in order for empty argument of get_palette to work

			-- used for some color tweaks later
			local catppuccin_flavour = require("catppuccin.palettes").get_palette() -- g:catppuccin_flavour's palette
			-- TODO ^ how the fuck do i get lsp autocompletion on this variable?

			require("catppuccin").setup({
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				transparent_background = false, -- TODO ???
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
					coc_nvim = false,
					lsp_trouble = false,
					cmp = true,
					lsp_saga = true,
					gitgutter = false,
					gitsigns = true,
					leap = false,
					telescope = true,
					nvimtree = {
						enabled = true,
						show_root = true,
						transparent_panel = false,
					},
					neotree = {
						enabled = false,
						show_root = true,
						transparent_panel = false,
					},
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
					dashboard = true,
					neogit = false,
					vim_sneak = false,
					fern = false,
					barbar = false,
					bufferline = true,
					markdown = true,
					lightspeed = false,
					ts_rainbow = false,
					hop = true,
					notify = true,
					telekasten = true,
					symbols_outline = true,
					mini = false,
					aerial = false,
					vimwiki = true,
					beacon = true,
					fidget = true,
				},
				color_overrides = {
					-- Related reading
					-- -> Catppuccin styleguide: https://github.com/catppuccin/catppuccin/blob/d7a1918a23fb28e912bfd721eedef0ff452db872/docs/style-guide.md

					-- TODO
					all = {
						-- the default rainbow is too red,
						-- i like this rainbow better:
						--[[ rainbow1 = { fg = catppuccin_flavour.blue }, ]]
						--[[ rainbow2 = { fg = catppuccin_flavour.teal }, ]]
						--[[ rainbow3 = { fg = catppuccin_flavour.green }, ]]
						--[[ rainbow4 = { fg = catppuccin_flavour.yellow }, ]]
						--[[ rainbow5 = { fg = catppuccin_flavour.peach }, ]]
						--[[ rainbow6 = { fg = catppuccin_flavour.red }, ]]
						--[[ rainbow7 = { fg = catppuccin_flavour.pink }, ]]
						rainbow1 = { fg = catppuccin_flavour.lavender },
						rainbow2 = { fg = catppuccin_flavour.blue },
						rainbow3 = { fg = catppuccin_flavour.teal },
						rainbow4 = { fg = catppuccin_flavour.green },
						rainbow5 = { fg = catppuccin_flavour.yellow },
						rainbow6 = { fg = catppuccin_flavour.peach },
						rainbow7 = { fg = catppuccin_flavour.pink },

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

				highlight_overrides = {
					-- TODO
					all = function(colors)
						return {
							-- alias catpuccin's `rainbowX` to indent_blankline's expected colors
							IndentBlanklineIndent1 = colors.rainbow1,
							IndentBlanklineIndent2 = colors.rainbow2,
							IndentBlanklineIndent3 = colors.rainbow3,
							IndentBlanklineIndent4 = colors.rainbow4,
							IndentBlanklineIndent5 = colors.rainbow5,
							IndentBlanklineIndent6 = colors.rainbow6,
							IndentBlanklineIndent7 = colors.rainbow7,
							-- IndentBlanklineContextChar = { fg = "#ff0000", bg = "#ff0000" },
							--[[ IndentBlanklineContextStart = { ]]
							--[[ 	fg = "#ff0000", ]]
							--[[ 	bg = "#ff0000", ]]
							--[[ 	-- guisp = "#ff0000", ]]
							--[[ 	-- gui = "undercurl", ]]
							--[[ }, ]]

							-- Improved "go to definition" highlighting
							SagaBeacon = { bg = catppuccin_flavour.yellow },

							-- the default greay isn't very visible
							CursorLine = { bg = catppuccin_flavour.surface0 }, -- row highlight
							CursorColumn = { bg = catppuccin_flavour.surface0 }, -- col highlight
							-- TODO styling Cursor doesn't seem to work for me. not sure why.
							--[[ Cursor = { ]]
							--[[ 	bg = catppuccin_flavour.yellow, ]]
							--[[ 	fg = catppuccin_flavour.surface3, ]]
							--[[ }, ]]
						}
					end,
				},

				--[[ custom_highlights = function(colors) ]]
				--[[ 	return { ]]
				--[[ 		-- Comment = { fg = colors.flamingo }, ]]
				--[[ 		-- TabLineSel = { bg = colors.pink }, ]]
				--[[ 		-- CmpBorder = { fg = colors.surface2 }, ]]
				--[[ 		-- Pmenu = { bg = colors.none }, ]]
				--[[]]
				--[[ 		-- TODO ]]
				--[[ 		-- IndentBlanklineContextChar = { fg = "#ff0000", bg = "#ff0000" }, ]]
				--[[ 		IndentBlanklineContextStart = { ]]
				--[[ 			fg = "#ff0000", ]]
				--[[ 			bg = "#ff0000", ]]
				--[[ 			-- guisp = "#ff0000", ]]
				--[[ 			-- gui = "undercurl", ]]
				--[[ 		}, ]]
				--[[ 	} ]]
				--[[ end, ]]
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Copilot AI assistant
	{ "github/copilot.vim", name = "copilot" },

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
		tag = "0.1.1",
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
					require("telescope").load_extension("fzf")
				end,
			},

			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin") -- builtin pickers: https://github.com/nvim-telescope/telescope.nvim#pickers

			telescope.setup({
				defaults = {
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
					path_display = { "smart" },
					winblend = 0,
					border = {},
					borderchars = nil,
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" },

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
						previewer = false,
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
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
						previewer = false,
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
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
									width = 0.5,
									height = 0.4,
									preview_width = 0.6,
								},
							},
						}),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")

			--[[ local find_files_opts = { ]]
			--[[ 	hidden = true, ]]
			--[[ 	file_ignore_patterns = { ]]
			--[[ 		"node_modules/.*", ]]
			--[[ 		".next", ]]
			--[[ 		".git", ]]
			--[[ 	} ]]
			--[[ } ]]

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
			-- Treesitter-based context as you scroll through code
			"nvim-treesitter/nvim-treesitter-context",

			-- Treesitter-based contextual comments (eg do {/* these */} in jsx depending on cursor location)
			"JoosepAlviste/nvim-ts-context-commentstring",

			-- Treesitter-based autoclose and autorename HTML tags
			"windwp/nvim-ts-autotag",

			-- Treesitter-based rainbow parenthesis
			-- "p00f/nvim-ts-rainbow",
			-- ^ TODO: DEPRECATED

			-- Regex explainer. Requires :TSInstall regex
			"bennypowers/nvim-regexplainer",

			-- Syntax aware text-objects, select, move, swap, and peek support
			"nvim-treesitter/nvim-treesitter-textobjects",

			-- Highlight function arguments
			"m-demare/hlargs.nvim",

			-- Treesitter-based local code dimming
			"folke/twilight.nvim",
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

				-- for nvim-ts-rainbow
				--[[ rainbow = { ]]
				--[[ 	enable = true, ]]
				--[[ 	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for ]]
				--[[ 	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean ]]
				--[[ 	max_file_lines = nil, -- Do not enable for files with more than n lines, int ]]
				--[[ 	-- colors = {}, -- table of hex strings ]]
				--[[ 	-- termcolors = {} -- table of colour name strings ]]
				--[[ }, ]]

				-- nvim-ts-context-commentstring stuff
				-- NOTE: some config in Comment.nvim relevant as well;
				-- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim=
				context_commentstring = {
					enable = true,
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
			})

			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				separator = "⠉", -- Separator between context and content. Should be a single character string, like '-'.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
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
			})

			-- Comment.nvim stuff
			require("Comment").setup({
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

				---Pre-hook, called before commenting the line
				---@type fun(ctx: CommentCtx):string
				pre_hook = function(ctx)
					-- BEGIN pre-hook for nvim-ts-context-commentstring
					local U = require("Comment.utils")
					local location = nil
					if ctx.ctype == U.ctype.block then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end
					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
						location = location,
					})
				end,
				-- END pre-hook for nvim-ts-context-commentstring

				---Post-hook, called after commenting is done
				---@type fun(ctx: CommentCtx)
				post_hook = nil,
			})

			require("hlargs").setup()

			require("regexplainer").setup({
				-- 'narrative'
				mode = "narrative", -- TODO: 'ascii', 'graphical'

				-- automatically show the explainer when the cursor enters a regexp
				auto = true,

				-- filetypes (i.e. extensions) in which to run the autocommand
				filetypes = {
					"html",
					"js",
					"cjs",
					"mjs",
					"ts",
					"jsx",
					"tsx",
					"cjsx",
					"mjsx",
				},

				-- Whether to log debug messages
				debug = false,

				-- 'split', 'popup', 'pasteboard'
				display = "popup",

				mappings = {
					toggle = "gR",
					-- examples, not defaults:
					-- show = 'gS',
					-- hide = 'gH',
					-- show_split = 'gP',
					-- show_popup = 'gU',
				},

				narrative = {
					separator = "\n",
				},
			})
		end,
	},

	-- Substitute variants (like case differences),
	-- eg: :%s/foo/bar/g
	-- eg: (visual selection) Subvert/foo/bar/g
	-- ... would replace all foo/Foo/FOO with bar/Bar/BAR
	-- It can do a lot more though, but that's 99% of what i do with it.
	{
		"tpope/vim-abolish",
	},

	-- Comment stuff out.
	{
		"numToStr/Comment.nvim",
		name = "Comment.nvim",
	},

	-- TODO is this working? lol
	-- Git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns.nvim",
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

	-- {
	-- 	'jose-elias-alvarez/typescript.nvim',
	-- 	name = 'typescript.nvim',
	-- 	opts = {
	-- 		disable_commands = false, -- prevent the plugin from creating Vim commands
	-- 		debug = false, -- enable debug logging for commands
	-- 		go_to_source_definition = {
	-- 			fallback = true, -- fall back to standard LSP definition on failure
	-- 		},
	-- 		--[[ server = { -- pass options to lspconfig's setup method ]]
	-- 		--[[ 	on_attach = ..., ]]
	-- 		--[[ }, ]]
	-- 	},
	-- },

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
			-- 'jose-elias-alvarez/typescript.nvim',
		},
		--[[ opts = { ]]
		--[[ 	sources = { ]]
		--[[ 		null_ls.builtins.formatting.stylua, ]]
		--[[ 		null_ls.builtins.diagnostics.eslint, ]]
		--[[ 		null_ls.builtins.completion.spell, ]]
		--[[ 	}, ]]
		--[[ } ]]

		-- npm install -g @fsouza/prettierd
		-- null_ls.builtins.formatting.prettierd

		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			-- TODO: use eslint language server for better experience than null-ls' builtin eslint
			--[[ require 'lspconfig'.eslint.setup({ ]]
			--[[ 	settings = { ]]
			--[[ 		packageManager = 'yarn' ]]
			--[[ 	}, ]]
			--[[ 	on_attach = function(client, bufnr) ]]
			--[[ 		vim.api.nvim_create_autocmd("BufWritePre", { ]]
			--[[ 			buffer = bufnr, ]]
			--[[ 			command = "EslintFixAll", ]]
			--[[ 		}) ]]
			--[[ 	end, ]]
			--[[ }) ]]

			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions
			local completion = null_ls.builtins.completion
			return {
				sources = {
					formatting.stylua, -- TODO auto install stylua
					-- formatting.prettier,
					-- formatting.eslint,
					-- formatting.fish_indent,
					-- formatting.prettierd,
					-- diagnostics.eslint,
					-- diagnostics.fish,
					-- diagnostics.tsc,
					code_actions.eslint,
					-- code_actions.gitsigns, -- TODO seems interesting
					-- completion.spell, -- TODO seems interesting
					--[[ null_ls.builtins.diagnostics.trail_space, ]]
					--[[ null_ls.builtins.formatting.trim_newlines, ]]
					--[[ null_ls.builtins.formatting.trim_whitespace, ]]
					null_ls.builtins.formatting.prettierd.with({
						condition = function(utils)
							-- TODO support other prettier config like .prettierrc, etc ?
							return utils.has_file({ ".prettierrc.js" })
						end,
					}),
					-- require("typescript.extensions.null-ls.code-actions"),
				},
				on_attach = function(client)
					if client.server_capabilities.documentFormattingProvider then
						vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 4000 })")
					end
				end,
			}
		end,
	},

	-- LSP (Language Server Protocol) integration
	-- TODO how do i install stuff so i dont have to do `npm install -g typescript-language-server` or whatever?
	{
		"neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
		dependencies = {
			-- LSP server for Lua
			"sumneko/lua-language-server",

			-- " Fancy lines for LSP messages
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",

			-- Lspsaga for improving LSP UI/UX (vague, i know)
			{
				"glepnir/lspsaga.nvim",
				event = "LspAttach",
				config = function()
					require("lspsaga").setup({})
				end,
				dependencies = {
					{ "nvim-tree/nvim-web-devicons" },
					{ "nvim-treesitter/nvim-treesitter" }, --Please make sure you install markdown and markdown_inline parser
				},
				opts = {
					ui = {
						-- This option only works in Neovim 0.9
						title = true,
						-- Border type can be single, double, rounded, solid, shadow.
						border = "single",
						winblend = 0,
						expand = "",
						collapse = "",
						code_action = "🔧",
						incoming = "",
						outgoing = "",
						hover = " ",
						-- kind = {}, -- defined in https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/lspkind.lua
					},

					-- may not *actually* be a lightbulb, that's just whawt the setting is called
					lightbulb = {
						enable = true,
						enable_in_insert = true,
						sign = true,
						sign_priority = 40,
						virtual_text = false,
					},
				},
				keys = {
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
						"<cmd>Lspsaga lsp_finder<CR>", -- command
						mode = "n",
						desc = "Finder (definitions, refs)",
					},

					-- Code actions
					{
						"<leader>ca", -- key map
						"<cmd>Lspsaga code_action<CR>", -- command
						mode = "n",
						desc = "Code actions",
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
						"gd", -- key map
						"<cmd>LspSaga goto_definition<CR>", -- command
						mode = "n",
						desc = "Go to definition",
					},

					-- Show line diagnostics
					{
						"<leader>cd", -- key map
						"<cmd>Lspsaga show_line_diagnostics<CR>", -- command
						mode = "n",
						desc = "Show line diagnostics",
					},

					-- Toggle outline
					{
						"<leader>to", -- key map
						"<cmd>Lspsaga toggle_outline<CR>", -- command
						mode = "n",
						desc = "Toggle outline",
					},

					-- Call hierarchy
					{
						"<Leader>ci", -- key map
						"<cmd>Lspsaga incoming_calls<CR>", -- command
						mode = "n",
						desc = "Incoming calls (call hierarchy)",
					},
					{
						"<Leader>co", -- key map
						"<cmd>Lspsaga outgoing_calls<CR>", -- command
						mode = "n",
						desc = "Outgoing calls (call hierarchy)",
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

			-- Fast as FUCK completion
			{
				"ms-jpq/coq_nvim",
				branch = "coq",
				-- lazy = false,
				init = function()
					-- coq_nvim config
					vim.g.coq_settings = {
						-- automatically start coq
						auto_start = true,
						clients = {
							snippets = {
								-- TODO how can I do a relative path to "./snippets" instead?
								user_path = vim.fn.expand("$HOME/.dotfiles/nvim/snippets"),
							},
						},
						keymap = {
							eval_snips = "<leader>j",
						},
					}
					local coq = require("coq")

					-- Snippets
					---- Edit snippets for current filetype: :COQsnips edit
					---- Compile snippets after changing: :COQsnips compile
					---- jump to next spots in snippet via: CTRL h

					local lsp = require("lspconfig")

					-- Configure LSP for ESLint
					lsp["eslint"].setup(coq.lsp_ensure_capabilities())
					-- Configure LSP for various servers via vscode-langservers-extracted (via `npm i -g vscode-langservers-extracted`)
					lsp["html"].setup(coq.lsp_ensure_capabilities())
					lsp["cssls"].setup(coq.lsp_ensure_capabilities())
					lsp["jsonls"].setup(coq.lsp_ensure_capabilities())
					-- Configure LSP for TypeScript (via `npm install -g typescript typescript-language-server`)
					lsp["tsserver"].setup(coq.lsp_ensure_capabilities({
						filetypes = {
							"javascript",
							"javascriptreact",
							"javascript.jsx",
							"typescript",
							"typescriptreact",
							"typescript.tsx",
						},
						-- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
					}))
					-- Configure LSP for Lua
					-- lsp['sumneko_lua'].setup(coq.lsp_ensure_capabilities({
					-- 	settings = {
					-- 		Lua = {
					-- 			runtime = {
					-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					-- 				version = "LuaJIT",

					-- 				-- Setup your lua path
					-- 				-- path = runtime_path,
					-- 			},

					-- 			diagnostics = {
					-- 				globals = {
					-- 					'vim',
					-- 				},
					-- 			},
					-- 		},
					-- 	},
					-- }))

					-- TODO bulk enable servers
					-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
					-- local servers = { 'tsserver' }
					-- for _, lsp in ipairs(servers) do
					--   lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
					--     -- on_attach = my_custom_on_attach,
					--   }))
					-- end
				end,
				dependencies = {
					-- 9000+ Snippets
					-- 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
					{
						"ms-jpq/coq.artifacts",
						branch = "artifacts",
						--[[ config = function() ]]
						--[[ end, ]]
					},

					{
						"ms-jpq/coq.thirdparty",
						-- branch = '3p',
						config = function()
							require("coq_3p")({
								{ src = "copilot", short_name = "COP", accept_key = "<c-f>" },
								{ src = "nvimlua", short_name = "nLUA" },
								-- ... (other sources)
							})
						end,
					},
				},
			},
			-- TODO: how to run :COQdeps then :COQnow auto after ^that^ ?
		},
		config = function()
			-- LSP configuration

			local lsp = require("lspconfig")

			-- TODO: WIP: Format config
			-- TODO: use eslint language server for better experience than null-ls' builtin eslint
			lsp.eslint.setup({
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

			-- -- Floating terminal
			-- vim.keymap.set(
			-- "n",
			-- "<A-d>",
			-- "<cmd>Lspsaga open_floaterm zsh<CR>",
			-- {
			-- 	silent = true,
			-- 	desc = 'Float term: open'
			-- }
			-- )
			-- vim.keymap.set(
			-- "t",
			-- "<A-d>",
			-- "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>",
			-- {
			-- 	silent = true,
			-- 	desc = 'Float term: close',
			-- }
			-- )

			-- -- ESLint fix all in buffer
			vim.keymap.set("n", "<leader>L", "<cmd>EslintFixAll<CR>", {
				silent = true,
				desc = "LSP: Lint auto-fix buffer",
			})
		end,
	},

	-- TODO maybe use a statusline instead?
	{
		"j-hui/fidget.nvim",
		name = "fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},

	-- opts
	-- {
	-- 	https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
	-- }
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
	text = "💡", -- lightbulb for information
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

-- Always use the current buffer's directory as the relative location for
-- commands and such. Mostly so I can :NERDTree and :sp/vsp anywhere.
vim.cmd("autocmd BufEnter * silent! lcd %:p:h")

-- TODO how to get strikethrough on @deprecated in tsx/jsdocs?
