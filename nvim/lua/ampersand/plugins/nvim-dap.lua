return function()
	local dap = require("dap")
	local ui = require("dap.ui.variables")

	vim.g.dap_virtual_text = true
	vim.fn.sign_define("DapBreakpoint", {
		text="■", texthl="DapBreakpoint", linehl="", numhl=""
	})
	vim.fn.sign_define("DapLogPoint", {
		text="●", texthl="DapLogPoint", linehl="", numhl=""
	})
	vim.fn.sign_define("DapStopped", {
		text="‣", texthl="DapStopped", linehl="", numhl=""
	})

	dap.adapters.cpp = {
		type = 'executable',
		attach = {
			pidProperty = "pid",
			pidSelect = "ask"
		},
		command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
		env = {
			LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
		},
		name = "lldb"
	}

	K.q {"d", dap.toggle_breakpoint}
	K.q {"r", dap.run_last}

	-- K.q {"dd", function()
	-- 	vim.cmd [[!make]]
	-- 	vim.cmd [[DebugC build]]
	-- end}

	Dap = {}
	function Dap.settings()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end

	vim.cmd [[autocmd FileType dap-repl lua Dap.settings()]]
	vim.cmd [[command! -complete=file -nargs=* DebugC lua require "ampersand.debuggers".start_c_debugger({<f-args>}, "gdb")]]
	vim.cmd [[command! -complete=file -nargs=* DebugRust lua require "ampersand.debuggers".start_c_debugger({<f-args>}, "gdb", "rust-gdb")]]

	local binds = {
		J = {"J", dap.step_over},
		K = {"K", dap.step_back},
		H = {"H", dap.step_out},
		L = {"L", dap.step_into},
		n = {"n", dap.continue},
		p = {"p", dap.reverse_continue},
		i = {"i", function()
			ui.hover()
		end},
	}
	local restore_binds = {}

	dap.listeners.after.event_initialized = {
		gitsigns = require("gitsigns").toggle_signs,
		keymaps = function()
			restore_binds = {}
			local keymaps = vim.api.nvim_get_keymap("n")
			for _, keymap in ipairs(keymaps) do
				if binds[keymap.lhs] then
					restore_binds[keymap.lhs] = keymap
					vim.api.nvim_del_keymap("n", keymap.lhs)
				end
			end
			for _, bind in pairs(binds) do
				K.n(bind)
			end
		end
	}

	dap.listeners.after.event_terminated = {
		gitsigns = require("gitsigns").toggle_signs,
		keymaps = function()
			print("Program terminated")
			for key, _ in pairs(binds) do
				vim.api.nvim_del_keymap("n", key)
				local keymap = restore_binds[key]
				if keymap then
					vim.api.nvim_buf_set_keymap(
						keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs,
						{ silent = keymap.silent == 1 }
					)
				end
			end
		end
	}
end
