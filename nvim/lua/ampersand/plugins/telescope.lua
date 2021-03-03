return function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local previewers = require("telescope.previewers")

	-- Settings {{{
	telescope.setup {
		defaults = {
			winblend = 15,
			file_ignore_patterns = {
				"node_modules/*", "\\.git/*",
				"%.png", "%.ico", "%.jpg", "%.icns", "%.map"
			},
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			show_line = false,
			prompt_prefix = '    ',

			mappings = {
				i = {
					["<C-q>"] = actions.send_to_qflist
				}
			}
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}
	
	telescope.load_extension("fzy_native")
	-- }}}

	-- Keybinds {{{
	local settings = {prompt_title="", results_title="", preview_title=""}

	K.q {"f", function() builtin.git_files(settings) end}
	K.q {"F", function() builtin.find_files(settings) end}
	K.q {"l", function() builtin.live_grep(settings) end}

	Plugins.telescope = {}
	function Plugins.telescope.git_files()
		builtin.git_files(settings)
	end
	-- }}}
end
