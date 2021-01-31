-- luacheck: new_globals Telescope

local plugin = {name = "telescope"}
Plugins[plugin.name] = plugin

function plugin.settings()
	Telescope = require("telescope")
	Telescope.builtin = require("telescope.builtin")
	local previewers = require("telescope.previewers")
	require("telescope").setup{
		defaults = {
			-- TODO: Fix color change on blank line
			-- winblend = 15,
			file_ignore_patterns = {
				"node_modules/*", ".git/*",
				"%.png", "%.ico", "%.jpg", "%.map"
			},
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			selection_strategy = "row",
			show_line = false,
			prompt_prefix = ' >'
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}
	require('telescope').load_extension('fzy_native')
end

function plugin.keybinds()
	local settings = [[{prompt_title="", results_title="", preview_title=""}]]
	K.sp('f', "<cmd>lua Telescope.builtin.git_files(" .. settings .. ")<CR>")
	K.sp('F', ":lua Telescope.builtin.find_files(" .. settings .. ")<CR>")
end

return function()
	Plugins.telescope.settings()
	K.plugin(Plugins.telescope)
end

