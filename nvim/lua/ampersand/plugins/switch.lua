local plugin = {name = "switch"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.switch_custom_definitions = {
		{'0', '1'},
		{"on", "off"},
		{"#t", "#f"}
	}
end

function plugin.keybinds()
	K.n("<C-s>", "<cmd>Switch<CR>")
end

return function()
	Plugins.switch.settings()
	K.plugin(Plugins.switch)
end

