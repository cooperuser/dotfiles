local plugin = {name = "commentary"}
Plugins[plugin.name] = plugin

function plugin.keybinds()
	K.group([[Duplicate current line and comment]], function()
		K.n("gcp", [["0yygcc"0P]])
		K.n("gcn", [["0yygcc"0p]])
	end)
end

return function()
	K.plugin(Plugins.commentary)
end

