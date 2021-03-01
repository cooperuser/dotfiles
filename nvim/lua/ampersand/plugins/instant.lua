local plugin = {name = "instant"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.instant_username = "cooper"
	vim.g.instant_cursor_hl_group_user1 = "Search"
end

function plugin.keybinds()

end

return function()
	Plugins.instant.settings()
	K.plugin(Plugins.instant)
end

