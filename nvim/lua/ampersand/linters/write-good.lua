return {
	command = "write-good",
	debounce = 100,
	args = { "--text=%text" },
	offsetLine = 0,
	offsetColumn = 1,
	sourceName = "write-good",
	formatLines = 1,
	formatPattern = {
		[[(.*)\s+on\s+line\s+(\d+)\s+at\s+column\s+(\d+)\s*()$]],
		{
			line = 2,
			column = 3,
			message = 1,
			security = 4
		}
	},
	securities = {
		[""] = "info"
	}
}
