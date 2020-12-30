local plugin = {name = "smoothie"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.smoothie_experimental_mappings = true
end

function plugin.keybinds()

end

return function()
	Plugins.smoothie.settings()
	K.plugin(Plugins.smoothie)
end

