local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require('telescope.pickers.entry_display')
local finders = require("telescope.finders")
local from_entry = require("telescope.from_entry")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")

local classes_cmd = {
	"find", "/home/ampersand/classes/2020-2021/spring",
	"-mindepth", "2",
	"-maxdepth", "2",
	"-type", "d",
}

local function get_name(path)
	local _, fall = string.find(path, "fall/")
	if fall then return string.sub(path, fall + 1) end
	local _, winter = string.find(path, "winter/")
	if winter then return string.sub(path, winter + 1) end
	local _, spring = string.find(path, "spring/")
	if spring then return string.sub(path, spring + 1) end
	local _, summer = string.find(path, "summer/")
	if summer then return string.sub(path, summer + 1) end
	return path
end

local function get_project(name)
	local split = string.find(name, "/")
	return {
		class = string.sub(name, 1, split - 1),
		project = string.sub(name, split + 1)
	}
end

local projects = {}
local results = utils.get_os_command_output(classes_cmd)
local longest_name = 0
for _, p in ipairs(results) do
	local name = get_name(p)
	local readme = vim.fn.readfile(p .. "/README.md")
	local data = get_project(name)

	local project = {}
	project.value = p
	project.path = p
	project.name = name
	project.ordinal = name
	project.readme = readme[2]
	project.class = data.class
	project.project = data.project
	projects[#projects+1] = project

	if #name > longest_name then longest_name = #name end
end

local displayer = entry_display.create {
	separator = "",
	items = {
		{width = 7},
		{width = 1},
		{width = longest_name + 4 - 8},
		{remaining = true},
	},
}

local function make_display(entry)
	return displayer {
		{entry.class, "Number", "Normal"},
		{"/", "Comment"},
		{entry.project, "CursorLineNr", "Normal"},
		{entry.readme, "Comment"},
	}
end

return function()
	return pickers.new {
		prompt_title = "Classes",
		finder = finders.new_table {
			results = projects,
			entry_maker = function(entry)
				entry.display = make_display
				return entry
			end
		},
		sorter = sorters.get_generic_fuzzy_sorter(),
		previewer = previewers.new_termopen_previewer {
			get_command = function(entry)
				return {"exa", "-T", "-L", "2", "--git-ignore", "--icons", entry.path}
			end
		},
		attach_mappings = function(buf_nr)
			actions.select_default:replace(function()
				local dir = from_entry.path(action_state.get_selected_entry())
				actions.close(buf_nr)
				vim.loop.chdir(dir)
				vim.cmd("cd " .. dir .. " | enew")
				vim.schedule( require("telescope.builtin").git_files)
			end)
			return true
		end,
	}:find()
end
