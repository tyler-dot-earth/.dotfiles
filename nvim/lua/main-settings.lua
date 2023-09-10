-- GOTO init.lua for mapleader and maplocalleader

-- use .editorconfig
vim.g.editorconfig = true

vim.opt.winblend = 30

-- Relative line numbers on left
vim.opt.relativenumber = true
-- Current line number on left
vim.opt.number = true
-- Highlight current row
vim.opt.cursorline = true
-- Highlight current column
vim.opt.cursorcolumn = true
-- Don't turn tabs to space
vim.opt.expandtab = false
-- How many columns a tab counts for
vim.opt.tabstop = 4
-- How many columns text is indented with the reindent operations
vim.opt.shiftwidth = 4
-- Required by feline, i guess?
vim.opt.termguicolors = true
-- Don't line wrap
vim.opt.wrap = false
-- Preferred split direction
vim.opt.splitbelow = true
-- Preferred vsplit direction
vim.opt.splitright = true
-- Always keep N number of lines from edge of screen
vim.opt.scrolloff = 5
-- Enable mouse support in (a)ll modes
vim.opt.mouse = "a"
-- Set the time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 500

-- Always show the sign column
vim.opt.signcolumn = "yes"

-- Special line characters
vim.opt.list = true
vim.opt.listchars = {
	-- tab = "⣿⣿",
	tab = "••",
	-- tab = "◆◆",
	eol = "↵",
	--[[ trail = "·", ]]
	--[[ precedes = "⦚", ]]
	--[[ extends = "⦚", ]]
	nbsp = "⎵",
	space = "░",
}
vim.opt.showbreak = "↪\\"
-- misc fun symbols: 🡆 🠶 🠊 ⮞ ⮚ ▶ ⎵ ⣿ ⠉ ⠈ ░ ▒ ▓ ► ◄ ↵ · • ◣ ◢ ◥ ◤ ◐ ◑ ⯺  ⯼ ☉ ⁞ ⦙ ┊ ⦚ × ▢
