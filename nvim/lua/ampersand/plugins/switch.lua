return function()
	vim.g.switch_mapping = "<C-s>"
	vim.g.switch_custom_definitions = {
		{'0', '1'},
		{"on", "off"},
		{"#t", "#f"},
		{"sem_wait", "sem_post"},
		{"sem_init", "sem_destroy"}
	}

	-- K.n {"<C-s>", "<cmd>Switch<CR>"}
end
