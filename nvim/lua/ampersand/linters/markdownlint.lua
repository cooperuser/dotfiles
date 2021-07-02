return {
	command = "markdownlint",
	isStderr = true,
	debounce = 100,
	args = { "--stdin" },
	offsetLine = 0,
	offsetColumn = 0,
	sourceName = "markdownlint",
	formatLines = 1,
	formatPattern = {
		[[^.*?:\s?(\d+)(?::(\d+)?)?\s(MD\d{3})\/([A-Za-z0-9-/]+)\s(.*)\[(.*)\]()$]],
		{
			line = 1,
			column = 2,
			code = 3,
			diag = 4,
			reason = 5,
			context = 6,
			security = 7,
			message = {5, "\n", 4, " [", 6, "]"}
		}
	},
	securities = {
		[""] = "warning"
	}
}
