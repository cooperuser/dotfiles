return function()
	vim.g.switch_custom_definitions = {
		{'0', '1'},
		{"on", "off"},
		{"#t", "#f"}
	}

	K.n {"<C-s>", "<cmd>Switch<CR>"}
end
