local plugin = {name = "tabi"}
Plugins[plugin.name] = plugin

function plugin.settings()
	require("tabi").setup()
end

function plugin.keybinds()

end

return function()
	Plugins.tabi.settings()
	TEMPMAP.plugin(Plugins.tabi)
end

