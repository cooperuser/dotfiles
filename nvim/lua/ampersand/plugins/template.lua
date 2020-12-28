local plugin = {name = "template"}
Plugins[plugin.name] = plugin

function plugin.settings()

end

function plugin.keybinds()

end

return function()
	Plugins.template.settings()
	K.plugin(Plugins.template)
end

