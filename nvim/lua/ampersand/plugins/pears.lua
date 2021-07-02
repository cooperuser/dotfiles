return function()
	local pears = require("pears")
	pears.setup(function(conf)
		conf.preset "tag_matching"

		local pumvisible = vim.fn.pumvisible
		local complete_info = vim.fn.complete_info

		conf.on_enter(function(pears_handle)
			if pumvisible() == 1 and complete_info().selected ~= -1 then
				return vim.fn["compe#confirm"]("<CR>")
			else
				pears_handle()
			end
		end)
	end)
end
