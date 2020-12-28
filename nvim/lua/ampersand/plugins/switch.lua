Plugins.switch = {}

function Plugins.switch.settings()
	vim.g.switch_custom_definitions = {
		{'0', '1'},
		{"on", "off"},
		{"#t", "#f"}
	}
end

return function()
	Plugins.switch.settings()
end

