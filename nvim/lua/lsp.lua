-- LSP configuration
-- TypeScript config
-- requirement: npm install -g typescript typescript-language-server
local lsp = require "lspconfig"

-- rename a symbol
-- vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })

-- Configure LSP for TypeScript
lsp.tsserver.setup {
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	-- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}

-- Configure LSP for Lua
require'lspconfig'.sumneko_lua.setup {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						'vim',
					},
				},
			},
		},
}

-- lsp_lines config
require("lsp_lines").setup()
vim.diagnostic.config({
	virtual_text = false,
	-- update_in_insert = true, -- aggressively real-time updates while in insert mode
}) -- disable regular virtual text diagnostic
vim.keymap.set(
	"",
	"<Leader>l",
	require("lsp_lines").toggle,
	{ desc = "Toggle lsp_lines" }
)


-- saga config
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
---- code action
local action = require("lspsaga.codeaction")
vim.keymap.set(
	"n",
	"<leader>ca",
	action.code_action,
	{
		silent = true,
		desc = 'Code action',
	})
-- vim.keymap.set("v", "<leader>ca", function()
-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
-- 	action.range_code_action()
-- end, { silent = true })
-- Rename symbol/variable
vim.keymap.set(
	"n",
	"gr",
	"<cmd>Lspsaga rename<CR>",
	{
		silent = true,
		desc = 'Rename',
	}
)
-- Preview definition
vim.keymap.set(
	"n",
	"gd",
	"<cmd>Lspsaga preview_definition<CR>",
	{
		silent = true,
		desc = 'Preview definition'
	}
)

-- Floating terminal
vim.keymap.set(
	"n",
	"<A-d>",
	"<cmd>Lspsaga open_floaterm zsh<CR>",
	{
		silent = true,
	}
)
vim.keymap.set(
	"t",
	"<A-d>",
	"<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>",
	{
		silent = true,
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
lsp.tsserver.setup(coq.lsp_ensure_capabilities())
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
--     -- on_attach = my_custom_on_attach,
--   }))
-- end
