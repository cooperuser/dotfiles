-- luacheck: new_globals Telescope

local plugin = {name = "telescope"}
Plugins[plugin.name] = plugin

function plugin.settings()
	Telescope = require("telescope")
	Telescope.builtin = require("telescope.builtin")
	Telescope.actions = require("telescope.actions")
	local previewers = require("telescope.previewers")
	require("telescope").setup{
		defaults = {
			-- TODO: Fix color change on blank line
			winblend = 15,
			file_ignore_patterns = {
				"node_modules/*", ".git/*",
				"%.png", "%.ico", "%.jpg", "%.icns", "%.map"
			},
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			-- selection_strategy = "row",
			show_line = false,
			prompt_prefix = '    ',

			mappings = {
				i = {
					["<C-q>"] = Telescope.actions.send_to_qflist
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
	require('telescope').load_extension('fzy_native')
end

local settings = {prompt_title="", results_title="", preview_title=""}

function plugin.git_files() Telescope.builtin.git_files(settings) end
function plugin.find_files() Telescope.builtin.find_files(settings) end
function plugin.live_grep() Telescope.builtin.live_grep(settings) end

function plugin.keybinds()
	-- local settings = [[{prompt_title="", results_title="", preview_title=""}]]
	TEMPMAP.sp('f', "<cmd>lua Plugins.telescope.git_files()<CR>")
	TEMPMAP.sp('F', "<cmd>lua Plugins.telescope.find_files()<CR>")
	TEMPMAP.sp('l', "<cmd>lua Plugins.telescope.live_grep()<CR>")
	-- TEMPMAP.sp('F', ":lua Telescope.builtin.find_files(" .. settings .. ")<CR>")
end

return function()
	Plugins.telescope.settings()
	TEMPMAP.plugin(Plugins.telescope)
end

