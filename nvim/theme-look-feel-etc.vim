
" Catppuccin theme configuration
lua << EOF
	require("catppuccin").setup {
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		transparent_background = false,
		term_colors = false,
		compile = {
			enabled = false,
			path = vim.fn.stdpath "cache" .. "/catppuccin",
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
			lsp_saga = false,
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
				enabled = true,
				colored_indent_levels = true,
			},
			dashboard = true,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = true,
			markdown = true,
			lightspeed = false,
			ts_rainbow = true,
			hop = false,
			notify = true,
			telekasten = true,
			symbols_outline = true,
			mini = false,
			aerial = false,
			vimwiki = true,
			beacon = true,
		},
		color_overrides = {},
		highlight_overrides = {},
	}
EOF


" Dev icons
lua << EOF
	require'nvim-web-devicons'.setup {
	 -- your personnal icons can go here (to override)
	 -- you can specify color or cterm_color instead of specifying both of them
	 -- DevIcon will be appended to `name`
	 override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		}
	 };
	 -- globally enable default icons (default to false)
	 -- will get overriden by `get_icons` option
	 default = true;
	}
EOF


" indent-blankline.nvim config
lua << EOF
	require("indent_blankline").setup {
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
			},
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	}
EOF

" nvim-notify config
lua << EOF
	-- require("notify")("My super important message")
EOF

" incline.nvim config
lua << EOF
require('incline').setup {
	debounce_threshold = {
		falling = 50,
		rising = 10
	},
	hide = {
		cursorline = false,
		focused_win = false,
		only_win = false
	},
	highlight = {
		groups = {
			InclineNormal = {
				default = true,
				group = "NormalFloat"
			},
			InclineNormalNC = {
				default = true,
				group = "NormalFloat"
			}
		}
	},
	ignore = {
		buftypes = "special",
		filetypes = {},
		floating_wins = true,
		unlisted_buffers = true,
		wintypes = "special"
	},
	-- render = "basic",
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
		local icon, color = require('nvim-web-devicons').get_icon_color(filename)
		return {
			{ icon, guifg = color },
			{ ' ' },
			{ filename },
		}
	end,
	window = {
		margin = {
			horizontal = 1,
			vertical = 0,
		},
		options = {
			signcolumn = "no",
			wrap = false
		},
		padding = 0,
		padding_char = " ",
		placement = {
			horizontal = "right",
			vertical = "top"
		},
		width = "fit",
		winhighlight = {
			active = {
				EndOfBuffer = "None",
				Normal = "InclineNormal",
				Search = "None"
			},
			inactive = {
				EndOfBuffer = "None",
				Normal = "InclineNormalNC",
				Search = "None"
			}
		},
		zindex = 50
	}
}
EOF
