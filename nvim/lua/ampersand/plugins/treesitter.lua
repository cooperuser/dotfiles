Plugins.treesitter = {}

function Plugins.treesitter.settings()
	local ts = require("nvim-treesitter.configs")
	ts.setup {
		ensure_installed = {
			"javascript",
			"typescript",
			"jsdoc",
			"python",
			"rust",
			"lua",
			"json",
			"regex"
		},
		use_languagetree = true,
		highlight = {
			enable = true
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25,
			persist_queries = false
		},
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = {"BufWrite", "CursorHold"},
		},
		incremental_selection = {
			enable = true
		}
	}
end

return function()
	Plugins.treesitter.settings()
end

