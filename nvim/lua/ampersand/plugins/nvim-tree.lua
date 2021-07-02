return function()
	-- Settings {{{
	vim.g.nvim_tree_ignore = {
		".git",
		"node_modules",
		"build",
		"dist",
		"target",
		"__pycache__"
	}
	vim.g.nvim_tree_width = 26
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_git_hl = 1
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_show_icons = {
		git = 0,
		folders = 1,
		files = 1
	}
	vim.g.nvim_tree_icons = {
		default = "",
		folder = {
			default = "▶",
			open = "▼",
			empty = "▷",
			empty_open = "▽",
			symlink = "◈"
		}
	}
	-- }}}

	-- Keybinds {{{
	K.q {"t", "<cmd>NvimTreeToggle<CR>"}
	-- }}}
end
