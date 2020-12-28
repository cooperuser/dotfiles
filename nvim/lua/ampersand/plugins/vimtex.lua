local plugin = {name = "vimtex"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.vimtex_view_method = "skim"
end

return function()
	Plugins.vimtex.settings()
end

