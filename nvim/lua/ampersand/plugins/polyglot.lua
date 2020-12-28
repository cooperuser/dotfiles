local plugin = {name = "polyglot"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.python_recommended_style = 0
end

return function()
	Plugins.polyglot.settings()
end

