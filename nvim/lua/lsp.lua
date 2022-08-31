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
	border_style = 'rounded',
	code_action_keys = {
		quit = "<ESC>", -- default: "q"
		exec = "<CR>",
	},
})
---- hover docs
vim.keymap.set(
	"n",
	"K",
	"<cmd>Lspsaga hover_doc<CR>",
	{
		silent = true,
		desc = 'Hover docs',
	}
)
---- finder (see definition, references)
vim.keymap.set(
	"n",
	"gh",
	"<cmd>Lspsaga lsp_finder<CR>",
	{
		silent = true,
		desc = 'Finder (definitions, refs)'
	}
)
---- Code action
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
-- Configure LSP for various servers via vscode-langservers-extracted
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
