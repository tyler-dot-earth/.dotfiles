" --------------------------------------
" TONS OF TREESITTER STUFF -------------
" --------------------------------------

lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "typescript", "tsx", "javascript", "json", "json5", "css", "html", "markdown", "yaml" },

		-- for nvim-ts-rainbow
		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},

		-- for nvim-ts-autotag
		autotag = {
			enable = true,
			filetypes = {
				'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
				'xml',
				'php',
				'markdown',
				'glimmer','handlebars','hbs'
				},
			skip_tags = {
				'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
				'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
				},
		},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    -- sync_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }

	require'treesitter-context'.setup{
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		separator = '⠉', -- Separator between context and content. Should be a single character string, like '-'.
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		patterns = {
			-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
			-- For all filetypes
			-- Note that setting an entry here replaces all other patterns for this entry.
			-- By setting the 'default' entry below, you can control which nodes you want to
			-- appear in the context window.
			default = {
					'class',
					'function',
					'method',
					'for',
					'while',
					'if',
					'switch',
					'case',
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
		mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
	}
EOF

" --------------------------------------
" nvim-ts-context-commentstring stuff
" NOTE: some config in Comment.nvim relevant as well;
" see https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim=
" --------------------------------------
lua << EOF
	require'nvim-treesitter.configs'.setup {
		context_commentstring = {
			enable = true,
		}
	}
EOF

" --------------------------------------
" Comment.nvim stuff
" --------------------------------------
lua << EOF
	require('Comment').setup {
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
				line = 'gcc',
				---Block-comment toggle keymap
				block = 'gbc',
		},

		---LHS of operator-pending mappings in NORMAL + VISUAL mode
		---@type table
		opleader = {
				---Line-comment keymap
				line = 'gc',
				---Block-comment keymap
				block = 'gb',
		},

		---LHS of extra mappings
		---@type table
		extra = {
				---Add comment on the line above
				above = 'gcO',
				---Add comment on the line below
				below = 'gco',
				---Add comment at the end of line
				eol = 'gcA',
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
			local U = require 'Comment.utils'
			local location = nil
			if ctx.ctype == U.ctype.block then
				location = require('ts_context_commentstring.utils').get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require('ts_context_commentstring.utils').get_visual_start_location()
				end
				return require('ts_context_commentstring.internal').calculate_commentstring {
					key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
					location = location,
					}
		end,
		-- END pre-hook for nvim-ts-context-commentstring

		---Post-hook, called after commenting is done
		---@type fun(ctx: CommentCtx)
		post_hook = nil,
}
EOF

lua << EOF
	require('hlargs').setup()
EOF


