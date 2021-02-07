local plugin = {name = "vimtex"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.vimtex_view_method = "zathura"
	-- vim.g.vimtex_compiler_method = "tectonic"
end

return function()
	Plugins.vimtex.settings()
end

