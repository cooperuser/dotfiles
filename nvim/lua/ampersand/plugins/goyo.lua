return function()
	K.q {'z', function()
		vim.cmd [[Goyo]]
		vim.cmd [[colorscheme glowbeam]]
		Plugins.galaxyline.toggle()
	end}

	K.q {'Z', function()
		vim.opt.laststatus = 2 - vim.api.nvim_get_option("laststatus")
		vim.opt.showtabline = 2 - vim.api.nvim_get_option("showtabline")
	end}
end
