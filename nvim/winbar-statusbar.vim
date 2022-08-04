" Feline statusbar / winbar configuration
lua << EOF
	local ctp_feline = require('catppuccin.groups.integrations.feline')

	-- optional, pass a lua table with config
	-- ctp_feline.setup()

	require("feline").setup({
		components = ctp_feline.get(),
	})

	require('feline').winbar.setup()
EOF

