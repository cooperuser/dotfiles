return function()
	local finders = require("ampersand.finders")

	local function get_plugin_count()
		local plugins = -1
		local loaded = 0
		for _, value in pairs(packer_plugins) do
			plugins = plugins + 1
			if value.loaded then loaded = loaded + 1 end
		end
		local output = plugins
		if plugins ~= loaded then output = loaded .. " / " .. plugins end
		return output .. " plugins loaded"
	end

	-- Settings {{{
	vim.g.dashboard_default_executive = "telescope"
	local version = vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\z[^\n]*")
	vim.g.dashboard_custom_shortcut = {
		last_session = "SPC l",
		-- find_history = "SPC h",
		find_file = "SPC f",
		new_file = "SPC n",
		change_colorscheme = "SPC c",
		find_word = "SPC w",
		book_marks = "SPC b"
	}

	-- vim.g.dashboard_custom_header = {
	-- 	'                  ╭🯈        ╭🯇┄┄┄┄┄┬┄┄┄┄┬╮             ',
	-- 	' ██🭏 ╰🯈🮈█🭏 ╶█████🭏 ┆███████🭐  🭅█    🭄█   🭁🭝┆  🭄██    🭄██ ',
	-- 	' ██🭒🭌  🮈██  ██🮂🮂🮂🮂 ┆██🭽▔▔▔██ ╶██    ██       ███🭝  🭁███ ',
	-- 	' ██ 🭒🭌 🮈██  ███🭌  🮲🮳██▏   ██╴ █🭝    █🭝  🭁██   ██ 🭁██🭝 ██ ',
	-- 	' ██  🭒🭌🮈██ ╶██▔▔   ╵██▏   ██   🭁🭝  🭁🭝   ▔██╴  ██  █🭝  ██ ',
	-- 	' 🭓█   🭓███  🭓████🭌  🭓███████    🭂██🭞     ██🭞  █🭞      █🭞 ',
	-- 	'  🭸🭸🭸🭸🭸🭸🭸🭸   🭸🭸🭸🭸🭸   🭸🭸🭸🭸🭸🭸🭸  🭸🭸🭸🭸🭸🭸🭸   🭸🭸🭸   🭸🭸🭸🭸🭸🭸🭸🭸🭸  ',
	-- 	'  -' .. version:sub(5)
	-- }
	vim.g.dashboard_custom_header = {
		'                                                         ',
		' ██🭏   🮈█🭏  █████🭏  ███████🭐  🭅█    🭄█   🭁🭝   🭄██    🭄██ ',
		' ███🭌  🮈██  ██🮃🮃🮃🮃  ██🭽▔▔🭾██  ██    ██        ███🭝  🭁███ ',
		' ██▍🭒🭌 🮈██  ███🭌    ██▏  ▕██  █🭝    █🭝  🭁██   ██ 🭁██🭝 ██ ',
		' ██▍ 🭒🭌🮈██  ██▔▔    ██🭼▁▁🭿██   🭁🭝  🭁🭝   ▔██   ██  █🭝  ██ ',
		' 🭓█▍  🭓███  🭓████🭌  🭓███████    🭂██🭞     ██🭞  █🭞      █🭞 ',
		'  🭸🭸🭸🭸🭸🭸🭸🭸   🭸🭸🭸🭸🭸   🭸🭸🭸🭸🭸🭸🭸  🭸🭸🭸🭸🭸🭸🭸   🭸🭸🭸   🭸🭸🭸🭸🭸🭸🭸🭸🭸  ',
		'  -' .. version:sub(5)
	}

	vim.g.dashboard_custom_footer = {get_plugin_count()}
	local sections = {
		{
			description = {" Edit a config file                  space v"},
			command = "cd " .. vim.fn.stdpath("config") .. " | Telescope git_files"
		},
		{
			description = {" Open a git file                     space f"},
			command = "lua Plugins.telescope.git_files()"
		},
		{
			description = {" Open a project                      space p"},
			command = ""
		},
		{
			description = {" Open a class                        space c"},
			command = ""
		},
		-- {
		-- 	description = {" Recently opened files               space h"},
		-- 	command = "DashboardFindHistory"
		-- },
		{
			description = {" Update plugins                      space u"},
			command = "PackerUpdate"
		},
		-- {
			-- 	description = {" Open last session                   space l"},
			-- 	command = ""
		-- },
		-- {
			-- 	description = {" Change colorscheme                  space c"},
			-- 	command = ""
		-- },
	}

	local ordered_sections = {}
	for index, value in ipairs(sections) do
		ordered_sections["a" .. index] = value
	end
	vim.g.dashboard_custom_section = ordered_sections

	vim.cmd("autocmd Filetype dashboard lua Plugins.dashboard.keybinds()")
	-- }}}

	-- Keybinds {{{
	Plugins.dashboard = {}
	function Plugins.dashboard.keybinds()
		local set_keymap = vim.api.nvim_buf_set_keymap
		local opts = {noremap = true}
		local function map(key, action)
			set_keymap(0, "n", "<Space>" .. key, "<cmd>" .. action .. "<CR>", opts)
		end
		vim.api.nvim_buf_set_keymap(0, "n", "i", "<cmd>enew | startinsert<CR>", {})
		vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", {})
		map("v", "cd " .. vim.fn.stdpath("config") .. " | Telescope git_files")
		map("p", "echo 'open project'")
		K.q {"c", function()
			finders.find_classes(obj, vim.fn["dashboard#change_to_dir"])
		end}
		-- map("h", "DashboardFindHistory")
		map("u", "PackerUpdate")
	end
	-- }}}
end
