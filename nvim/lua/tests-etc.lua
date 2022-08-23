local neotest = require('neotest')

neotest.setup({
	-- ...,
	adapters = {
		require('neotest-vitest'),

		-- require('neotest-jest')({
			-- jestCommand = "npm test --",
			-- jestConfigFile = "custom.jest.config.ts",
			-- env = { CI = true },
			-- cwd = function(path)
				-- return vim.fn.getcwd()
			-- end,
		-- }),
	}
})

-- vim.keymap.set("n", "<LocalLeader>t", function()
vim.keymap.set("n", "<Leader>T", function()
	neotest.run.run(vim.fn.expand("%"))
	neotest.summary.open()
end, {
	silent = true,
	desc = 'Neotest: Open test summary'
})

vim.keymap.set("n", "<Leader>R", function()
	neotest.run.run(vim.fn.expand("%"))
	neotest.summary.open()
end, {
	silent = true,
	desc = 'Neotest: Run nearest test'
})
