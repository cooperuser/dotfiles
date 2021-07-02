return function ()
	local devicons = require("nvim-web-devicons")
	devicons.setup {
		override = {
			rs = {
				icon = "",
				color = "#dea584",
				name = "Rs"
			}
		}
	}
end
