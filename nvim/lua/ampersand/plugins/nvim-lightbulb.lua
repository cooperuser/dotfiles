return function()
	-- Plugins.lightbulb = {}
	-- function Plugins.lightbulb.run()
	-- 	local cursor = vim.api.nvim_win_get_cursor(0)
	-- 	-- local x = 5
	-- 	require("nvim-lightbulb").update_lightbulb {
	-- 		sign = {
	-- 			enabled = false,
	-- 			priority = 1000
	-- 		},
	-- 		float = {
	-- 			enabled = false,
	-- 			text = "💡",
	-- 			win_opts = {
	-- 				winblend = 100,
	-- 				offset_x = -cursor[2] - 3,
	-- 				anchor = "SW",
	-- 			}
	-- 		},
	-- 		virtual_text = {
	-- 			enabled = false,
	-- 			-- Text to show at virtual text
	-- 			text = "💡",
	-- 		}
	-- 	}
	-- end

	-- vim.cmd [[autocmd CursorHold * lua Plugins.lightbulb.run()]]
	-- vim.fn.sign_define('LightBulbSign', { text = "", numhl="Folded" })
end
