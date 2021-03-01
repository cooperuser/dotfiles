local plugin = {name = "nvimtree"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.nvim_tree_ignore = {".git", "node_modules", "build", "dist"}
	vim.g.nvim_tree_width = 26
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_git_hl = 1
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



	--[[
	let g:nvim_tree_icons = {
			\ 'default': '',
			\ 'symlink': '',
			\ 'git': {
			\   'unstaged': "✗",
			\   'staged': "✓",
			\   'unmerged': "",
			\   'renamed': "➜",
			\   'untracked': "★"
			\   },
			\ 'folder': {
			\   'default': "",
			\   'open': "",
			\   'symlink': "",
			\  }
			\ }

	--]]
end

function plugin.keybinds()
	K.sp("t", "<cmd>NvimTreeToggle<CR>")
end

return function()
	Plugins.nvimtree.settings()
	K.plugin(Plugins.nvimtree)
end

