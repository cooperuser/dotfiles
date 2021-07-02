return function()
	-- Utility {{{
	local settings = {
		fullscreen = "--wintype=floating --position=center",
		floating = "--wintype=floating --position=center --width=0.6 --height=0.6",
		normal = "--wintype=vsplit --width=80"
	}

	-- local function runnerSend(command)
	-- 	local cmd = "clear"
	-- 	if command ~= "clear" then cmd = vim.g.project_commands[command] end
	-- 	vim.cmd("FloatermSend --name=runner " .. cmd)
	-- end

	-- local function toggle(name, command)
	-- 	local bufnr = vim.fn["floaterm#terminal#get_bufnr"](name)
	-- 	if bufnr == -1 then
	-- 		local args = "--name=" .. name .. " --title=" .. name .. " "
	-- 		vim.cmd("FloatermNew --autoclose=1 " .. args .. command)
	-- 	else
	-- 		vim.cmd("FloatermToggle " .. name)
	-- 	end
	-- end
	-- }}}

	-- Settings {{{
	-- vim.g.floaterm_borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}
	-- vim.g.floaterm_borderchars = {"🬭", "▌", "🬂", "▐", "🬞", "🬏", "🬀", "🬁"}

	vim.g.floaterm_borderchars = {"▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼"}
	-- vim.g.floaterm_borderchars = {"█", "█", "█", "█", "█", "█", "█", "█"}
	vim.g.floaterm_title = ""

	-- vim.cmd("hi FloatermBorder guifg=orange")
	vim.cmd("hi FloatermBorder guifg=#3f444a guibg=#101010")
	vim.cmd("hi Floaterm guibg=#101010")
	vim.cmd("autocmd FileType floaterm setlocal winblend=0")

	vim.g.project_commands = {
		run = "yarn build;yarn start",
		start = "yarn start",
		build = "yarn build",
		lint = "yarn lint",
		test = "echo 'test'"
	}
	-- }}}

	-- Settings {{{
	local switch = "<C-\\><C-n><C-w><C-w>"
	local run = "<cmd>AsyncTask run<CR>"
	local both = {
		toggle = {"<Leader><Leader>", "<cmd>FloatermToggle --name=runner<CR>"};
		kill = {"<Leader>d", "<cmd>FloatermKill<CR>"};
		-- swap = {"<Leader>f", "<C-w><C-w>"}
	}

	for _, b in pairs(both) do
		K.n(b)
		K.t(b)
	end

	K.n {"<Leader>r", run}
	K.n {"<Leader>l", "<C-w><C-w><C-l>" .. switch}
	K.t {"<Leader>l", "<C-l>"}
	K.n {"<Leader>x", "<C-w><C-w><C-\\><C-n>"}
	K.t {"<Leader>x", "<C-\\><C-n>"}
	K.t {"<Leader>w", "<C-w>"}

	K.t {"<Leader>c", "<cmd>FloatermUpdate " .. settings.floating .. "<CR>"}
	K.t {"<Leader>v", "<cmd>FloatermUpdate " .. settings.normal .. "<CR>"}
	K.t {"<Leader>f", "<cmd>FloatermUpdate " .. settings.fullscreen .. "<CR>"}
	-- }}}
end
