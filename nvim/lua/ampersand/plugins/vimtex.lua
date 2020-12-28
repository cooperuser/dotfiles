Plugins.vimtex = {}

function Plugins.vimtex.settings()
	vim.g.vimtex_view_method = "skim"
end

return function()
	Plugins.vimtex.settings()
end

