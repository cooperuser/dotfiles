local plugin = {name = "treesitter"}
Plugins[plugin.name] = plugin

function plugin.settings()
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
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		-- textobjects = {
		-- 	swap = {
		-- 		enable = true,
		-- 		swap_next = {
		-- 			["<Leader>a"] = "@parameter.inner",
		-- 		},
		-- 		swap_previous = {
		-- 			["<Leader>A"] = "@parameter.inner",
		-- 		},
		-- 	},
		-- }
	}
end

return function()
	Plugins.treesitter.settings()
end

