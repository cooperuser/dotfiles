local plugin = {name = "markdownpreview"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.mkdp_markdown_css = "/Users/ampersand/.config/nvim/plugin/markdownpreview/markdown.css"
	vim.g.mkdp_highlight_css = "/Users/ampersand/.config/nvim/plugin/markdownpreview/markdown_dark.css"
end

function plugin.keybinds()

end

return function()
	Plugins.markdownpreview.settings()
	K.plugin(Plugins.markdownpreview)
end

