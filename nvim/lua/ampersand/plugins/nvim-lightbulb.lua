return function()
	Plugins.lightbulb = {}
	function Plugins.lightbulb.run()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local x = 5
		require("nvim-lightbulb").update_lightbulb {
			sign = {
				enabled = false
			},
			float = {
				enabled = true,
				text = "💡",
				win_opts = {
					winblend = 100,
					offset_x = -cursor[2] - 3,
					anchor = "SW",
				}
			}
		}
	end

	vim.cmd [[autocmd CursorHold * lua Plugins.lightbulb.run()]]
end
