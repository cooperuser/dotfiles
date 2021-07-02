return function(args, mi_mode, mi_debugger_path)
	local dap = require "dap"
	local  last_gdb_config
	if args and #args > 0 then
		last_gdb_config = {
			type = "cpp",
			name = args[1],
			request = "launch",
			program = table.remove(args, 1),
			args = args,
			cwd = vim.fn.getcwd(),
			env = {}, -- environment variables are set via `ENV_VAR_NAME=value` pairs
			externalConsole = true,
			MIMode = mi_mode or "gdb",
			MIDebuggerPath = mi_debugger_path
		}
	end

	if not last_gdb_config then
		print('No binary to debug set! Use ":DebugC <binary> <args>" or ":DebugRust <binary> <args>"')
		return
	end

	dap.run(last_gdb_config)
	dap.repl.open({number = false, relativenumber = false}, "50vsplit")
end
