return function()
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
			enable = true,
			-- custom_captures = {
			-- 	["declaration.declarator"] = "TSType"
			-- }
		},
		indent = {
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
			}
		},
		autotag = {
			enable = false,
			filetypes = { "tsx", "typescriptreact", "html" , "xml" },
		},
		rainbow = {
			enable = true,
			extended_mode = true
		},
		textobjects = {
			swap = {
				enable = true,
				swap_next = {
					[",mj"] = "@function.outer",
					[",ml"] = "@parameter.inner",
				},
				swap_previous = {
					[",mk"] = "@function.outer",
					[",mh"] = "@parameter.inner",
				},
			},
		}
	}
end
