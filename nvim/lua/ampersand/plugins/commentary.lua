local plugin = {name = "commentary"}
Plugins[plugin.name] = plugin

function plugin.keybinds()
	TEMPMAP.group([[Duplicate current line and comment]], function()
		TEMPMAP.n("gcp", [["0yygcc"0P]])
		TEMPMAP.n("gcn", [["0yygcc"0p]])
	end)
end

return function()
	TEMPMAP.plugin(Plugins.commentary)
end

