local plugin = {name = "telescope"}
Plugins[plugin.name] = plugin

function plugin.settings()
	Telescope = require("telescope.builtin")

	require("telescope").setup({
		defaults = {
			winblend = 15,
			file_sorter = require("telescope.sorters").get_fzy_sorter
		}
	})
end

function plugin.keybinds()
	K.sp('f', "<cmd>lua Telescope.git_files()<CR>")
	local ignore = [[{file_ignore_patterns = {"node_modules/*", ".git/*"}}]]
	K.sp('F', ":lua Telescope.find_files(" .. ignore ..  ")<CR>")
end

return function()
	Plugins.telescope.settings()
	K.plugin(Plugins.telescope)
end

