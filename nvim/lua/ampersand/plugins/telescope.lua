Plugins.telescope = {}

function Plugins.telescope.settings()
	Telescope = require("telescope.builtin")

	require("telescope").setup({
		defaults = {
			winblend = 15,
			file_sorter = require("telescope.sorters").get_fzy_sorter
		}
	})
end

function Plugins.telescope.keybinds()
	K.nnoremap("<space>f", ":lua Telescope.git_files()<CR>", {silent = true})
	K.nnoremap("<space>F",
		":lua Telescope.find_files(" ..
			[[{file_ignore_patterns = {"node_modules/*", ".git/*"}}]] ..
		")<CR>",
		{silent = true}
	)
end

return function()
	Plugins.telescope.settings()
	Plugins.telescope.keybinds()
end

