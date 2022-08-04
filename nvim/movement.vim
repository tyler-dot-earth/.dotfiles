" Hot (easymotion) config
lua << EOF
	require'hop'.setup()
	vim.api.nvim_set_keymap('', 'gw', "<cmd>lua require'hop'.hint_words({ keys = 'fjwiozs' })<cr>", {})
EOF
