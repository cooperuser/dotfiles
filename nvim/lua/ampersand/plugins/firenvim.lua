return function()
	vim.opt.guifont = [[Iosevka\ Copper:h13]]
	vim.cmd [[au BufEnter leetcode.com_*.js set filetype=typescript]]

	vim.g.firenvim_config = {
		localSettings = {
			[".*"] = {
				takeover = "never"
			}
		}
	}

	if vim.g.started_by_firenvim then
		vim.cmd [[autocmd BufEnter * lua Plugins.firenvim.bufenter()]]
	end

	Plugins.firenvim = {}
	function Plugins.firenvim.bufenter()
		if vim.api.nvim_get_option("lines") < 5 then
			vim.opt.number = false
			vim.opt.relativenumber = false
			vim.opt.signcolumn = "no"
			vim.cmd("startinsert")
		end

		vim.opt.wrap = true
		vim.opt.linebreak = true
	end
end
