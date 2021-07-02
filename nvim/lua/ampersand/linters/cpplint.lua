return {
	command = "cpplint",
	args = {
		"--filter=-legal/copyright,-whitespace/tab,-whitespace/newline,-build/include_subdir,-readability/braces,-readability/casting,-runtime/int,-runtime/printf,-runtime/threadsafe_fn",
		"%file"
	},
	debounce = 100,
	isStderr = true,
	isStdout = false,
	sourceName = "cpplint",
	offsetLine = 0,
	offsetColumn = 0,
	formatPattern = {
		-- [[^{^:}+:(\\d+):(\\d+)?\\s+({^:}+?)\\s\\{(\\d)\\}$]],
		"(.*):(\\d*):(\\d*)  (.*)  \\[(.*)\\] \\[(\\d+)\\]",
		{
			line = 2,
			-- column = 2,
			message = 4,
			security = 6
		}
	},
	securities = {
		"hint",
		"info",
		"info",
		"info",
		"info",
		"hint"
	}
	-- securities = {
	-- 	"hint",
	-- 	"info",
	-- 	"info",
	-- 	"info",
	-- 	"info",
	-- 	"hint",
	-- 	"info",
	-- 	"info",
	-- 	"info",
	-- 	"info",
	-- 	"info"
	-- }
}
