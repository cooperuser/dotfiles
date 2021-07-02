return function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local previewers = require("telescope.previewers")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")

	-- Settings {{{
	telescope.setup {
		defaults = {
			winblend = 15,
			file_ignore_patterns = {
				"node_modules/*", "\\.git/*", "target/*",
				"%.png", "%.ico", "%.jpg", "%.icns", "%.map", "%.out",
				"CuTest.c", "CuTest.h"
			},
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			show_line = false,
			selection_caret = "╶‣ ",
			entry_prefix = "   ",
			prompt_prefix = '    ',

			mappings = {
				i = {
					["<C-q>"] = actions.send_to_qflist;
					["<Esc>"] = actions.close;
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

	vim.cmd [[autocmd FileType TelescopePrompt let b:lexima_disabled = 1]]
	-- }}}

	-- Keybinds {{{
	local settings = {prompt_title="", results_title="", preview_title=""}

	K.q {"f", function() builtin.git_files(settings) end}
	K.q {"F", function() builtin.find_files(settings) end}
	K.q {"l", function() builtin.live_grep() end}

	Plugins.telescope = {}
	function Plugins.telescope.git_files()
		builtin.git_files(settings)
	end
	-- }}}
end
