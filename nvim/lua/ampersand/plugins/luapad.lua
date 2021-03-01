local plugin = {name = "luapad"}
Plugins[plugin.name] = plugin

function plugin.settings()
	require("luapad").config {
		error_indicator = false
	}
end

function plugin.keybinds()
	K.sp("L", "<cmd>Luapad<CR>")
end

return function()
	Plugins.luapad.settings()
	K.plugin(Plugins.luapad)
end

