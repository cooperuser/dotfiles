local bg = require("ampersand.background")

local plugin = {name = "goyo"}
Plugins[plugin.name] = plugin

function plugin.goyo_enter()
	vim.cmd("silent !tmux set status off")
end

function plugin.goyo_leave()
	vim.cmd("silent !tmux set status on")
	bg.apply()
end

function plugin.settings()
	vim.cmd("autocmd! User GoyoEnter nested lua Plugins.goyo.goyo_enter()")
	vim.cmd("autocmd! User GoyoLeave nested lua Plugins.goyo.goyo_leave()")
end

function plugin.keybinds()
	K.sp("Z", "<cmd>Goyo<CR>")
end

return function()
	Plugins.goyo.settings()
	K.plugin(Plugins.goyo)
end

