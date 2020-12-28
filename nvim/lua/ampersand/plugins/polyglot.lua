Plugins.polyglot = {}

function Plugins.polyglot.settings()
	vim.g.python_recommended_style = 0
end

return function()
	Plugins.polyglot.settings()
end

