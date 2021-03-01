local plugin = {name = "quickscope"}
Plugins[plugin.name] = plugin

function plugin.settings()

end

function plugin.keybinds()
	vim.g.qs_highlight_on_keys = {"f", "F", "t", "T"}
end

return function()
	Plugins.quickscope.settings()
	TEMPMAP.plugin(Plugins.quickscope)
end

