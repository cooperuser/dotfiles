Plugins.fzf = {}

function Plugins.fzf.settings()
	vim.g.fzf_layout = {
		window = {
			width = 0.8,
			height = 0.8
		}
	}
end

return function()
	Plugins.fzf.settings()
end

