-- luacheck: new_globals RunnerSend

local plugin = {name = "floaterm"}
Plugins[plugin.name] = plugin

local settings = {
	floating = "--wintype=floating --position=center --width=0.6 --height=0.6",
	normal = "--wintype=normal --position=right --width=80 --height=24"
}

local function bothNT(key, command)
	K.n(key, command)
	K.t(key, command)
end

function RunnerSend(command)
	local cmd = "clear"
	if command ~= "clear" then cmd = vim.g.project_commands[command] end
	vim.cmd("FloatermSend --name=runner " .. cmd)
end

function plugin.toggle(name, command)
	local bufnr = vim.fn["floaterm#terminal#get_bufnr"](name)
	if bufnr == -1 then
		local args = "--name=" .. name .. " --title=" .. name .. " "
		vim.cmd("FloatermNew --autoclose=1 " .. args .. command)
	else
		vim.cmd("FloatermToggle " .. name)
	end
end

function plugin.settings()
	vim.g.floaterm_borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}

	vim.cmd("hi FloatermBorder guifg=orange")
	vim.cmd("autocmd FileType floaterm setlocal winblend=0")

	vim.g.project_commands = {
		run = "yarn build;yarn start",
		start = "yarn start",
		build = "yarn build",
		lint = "yarn lint",
		test = "echo 'test'"
	}
end

function plugin.keybinds()
	-- TODO: Document these keybinds

	bothNT("<Leader><Leader>", "<cmd>FloatermToggle --name=runner<CR>")

	local switch = "<C-\\><C-n><C-w><C-w>"
	local run = "<cmd>AsyncTask run<CR>"
	K.n("<Leader>r", run)
	K.n("<Leader>l", "<C-w><C-w><C-l>" .. switch)
	K.t("<Leader>l", "<C-l>")
	K.n("<Leader>x", "<C-w><C-w><C-\\><C-n>")
	K.t("<Leader>x", "<C-\\><C-n>")

	K.t("<Leader>w", "<C-w>")

	bothNT("<Leader>d", "<cmd>FloatermKill<CR>")
	bothNT("<Leader>f", "<C-w><C-w>")

	K.t("<Leader>c", "<cmd>FloatermUpdate " .. settings.floating .. "<CR>")
	K.t("<Leader>v", "<cmd>FloatermUpdate " .. settings.normal .. "<CR>")
end

return function()
	Plugins.floaterm.settings()
	K.plugin(Plugins.floaterm)
end

