-- LSP configuration
-- TypeScript config
-- requirement: npm install -g typescript typescript-language-server
local lsp = require "lspconfig"

vim.keymap.set(
	"n",
	"<leader>f",
	"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
	{
		desc = 'LSP: format',
		silent = true,
	}
)

-- lsp_lines config
require("lsp_lines").setup()
vim.diagnostic.config({
	virtual_text = false,
	-- update_in_insert = true, -- aggressively real-time updates while in insert mode
}) -- disable regular virtual text diagnostic
vim.keymap.set(
	"",
	"<Leader>l",
	"<cmd>lua require('lsp_lines').toggle()<CR>",
	{ desc = "Toggle lsp_lines" }
)
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


-- lspsaga config for prettier LSP UI
local saga = require 'lspsaga'

-- saga.init_lsp_saga() -- use default config
saga.init_lsp_saga({
	-- rename_action_quit = "<C-c>",

	-- "single" | "double" | "rounded" | "bold" | "plus"
	border_style = 'rounded',

	--the range of 0 for fully opaque window (disabled) to 100 for fully
	--transparent background. Values between 0-30 are typically most useful.
	saga_winblend = 20,

	-- when cursor in saga window you config these to move
	move_in_saga = {
		prev = '<C-p>',
		next = '<C-n>'
	},

	-- Error, Warn, Info, Hint
	-- use emoji like
	-- { "🙀", "😿", "😾", "😺" }
	-- or
	-- { "😡", "😥", "😤", "😐" }
	-- and diagnostic_header can be a function type
	-- must return a string and when diagnostic_header
	-- is function type it will have a param `entry`
	-- entry is a table type has these filed
	-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
	diagnostic_header = { " ", " ", " ", "ﴞ " },

	-- show diagnostic source
	show_diagnostic_source = true,

	-- add bracket or something with diagnostic source, just have 2 elements
	diagnostic_source_bracket = {},

	-- preview lines of lsp_finder and definition preview
	max_preview_lines = 10,

	-- use emoji lightbulb in default
	code_action_icon = "💡",

	-- if true can press number to execute the codeaction in codeaction window
	code_action_num_shortcut = true,

	-- same as nvim-lightbulb but async
	code_action_lightbulb = {
			enable = true,
			enable_in_insert = true,
			cache_code_action = true,
			sign = true, -- show in "sign" column
			update_time = 150,
			sign_priority = 20,
			virtual_text = false, -- show at "end" of line
	},

	-- finder icons
	finder_icons = {
		def = '  ',
		ref = '諭 ',
		link = '  ',
	},

	-- finder do lsp request timeout
	-- if your project big enough or your server very slow
	-- you may need to increase this value
	finder_request_timeout = 1500,

	-- set antoher colorscheme in preview window
	finder_preview_hl_ns = 0,

	finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			quit = "q",
			scroll_down = "<C-f>",
			scroll_up = "<C-b>", -- quit can be a table
	},

	code_action_keys = {
		quit = "<ESC>", -- default: "q"
		exec = "<CR>",
	},

	rename_action_quit = "<C-c>",

	rename_in_select = true,

	definition_preview_icon = "  ",

	-- show symbols in winbar must nightly
	symbol_in_winbar = {
			in_custom = false,
			enable = false,
			separator = ' ',
			show_file = true,
			click_support = false,
	},

	-- show outline
	show_outline = {
		win_position = 'right',
		--set special filetype win that outline window split.like NvimTree neotree
		-- defx, db_ui
		win_with = '',
		win_width = 30,
		auto_enter = true,
		auto_preview = true,
		virt_text = '┃',
		jump_key = 'o',
		-- auto refresh when change buffer
		auto_refresh = true,
	},

	-- custom lsp kind
	-- usage { Field = 'color code'} or {Field = {your icon, your color code}}
	custom_kind = {},

	-- if you don't use nvim-lspconfig you must pass your server name and
	-- the related filetypes into this table
	-- like server_filetype_map = { metals = { "sbt", "scala" } }
	server_filetype_map = {},
})

---- Hover docs
vim.keymap.set(
	"n",
	"K",
	"<cmd>Lspsaga hover_doc<CR>",
	{
		silent = true,
		desc = 'Hover docs',
	}
)

---- Finder (see definition, references)
vim.keymap.set(
	"n",
	"gh",
	"<cmd>Lspsaga lsp_finder<CR>",
	{
		silent = true,
		desc = 'Finder (definitions, refs)'
	}
)

---- Code actions
vim.keymap.set(
	"n",
	"<leader>ca",
	'<cmd>Lspsaga code_action<CR>',
	{
		silent = true,
		desc = 'LSP: Code action',
	}
)

-- Rename symbol/variable
vim.keymap.set(
	"n",
	"gr",
	"<cmd>Lspsaga rename<CR>",
	{
		silent = true,
		desc = 'LSP: Rename',
	}
)
-- Preview definition
vim.keymap.set(
	"n",
	"gd",
	"<cmd>Lspsaga preview_definition<CR>",
	{
		silent = true,
		desc = 'LSP: Preview definition'
	}
)

-- Show line diagnostics
vim.keymap.set(
	"n",
	"<leader>cd",
	"<cmd>Lspsaga show_line_diagnostics<CR>",
	{
		silent = true,
		desc = 'Show line diagnostics'
	}
)

-- Floating terminal
vim.keymap.set(
	"n",
	"<A-d>",
	"<cmd>Lspsaga open_floaterm zsh<CR>",
	{
		silent = true,
		desc = 'Float term: open'
	}
)
vim.keymap.set(
	"t",
	"<A-d>",
	"<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>",
	{
		silent = true,
		desc = 'Float term: close',
	}
)

-- coq_nvim config
vim.g.coq_settings = {
	-- automatically start coq
	auto_start = true,
	clients = {
		snippets = {
			-- TODO how can I do a relative path to "./snippets" instead?
			user_path = vim.fn.expand('$HOME/.dotfiles/nvim/snippets'),
		}
	},
	keymap = {
		eval_snips = '<leader>j',
	}
}
local coq = require("coq")

-- Snippets
---- Edit snippets for current filetype: :COQsnips edit
---- Compile snippets after changing: :COQsnips compile
---- jump to next spots in snippet via: CTRL h

-- Configure LSP for ESLint
lsp['eslint'].setup(coq.lsp_ensure_capabilities())
-- Configure LSP for various servers via vscode-langservers-extracted (via `npm i -g vscode-langservers-extracted`)
lsp['html'].setup(coq.lsp_ensure_capabilities())
lsp['cssls'].setup(coq.lsp_ensure_capabilities())
lsp['jsonls'].setup(coq.lsp_ensure_capabilities())
-- Configure LSP for TypeScript
lsp['tsserver'].setup(coq.lsp_ensure_capabilities({
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	-- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}))
-- Configure LSP for Lua
lsp['sumneko_lua'].setup(coq.lsp_ensure_capabilities({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",

				-- Setup your lua path
				-- path = runtime_path,
			},

			diagnostics = {
				globals = {
					'vim',
				},
			},
		},
	},
}))

-- TODO bulk enable servers
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
--     -- on_attach = my_custom_on_attach,
--   }))
-- end
