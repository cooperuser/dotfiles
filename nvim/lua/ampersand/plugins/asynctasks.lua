local plugin = {name = "asynctasks"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.cmd([[
		function! s:run_floaterm(opts)
			let curr_bufnr = floaterm#curr()
			if has_key(a:opts, 'silent') && a:opts.silent == 1
				FloatermHide!
			endif
			call floaterm#terminal#send(curr_bufnr, [a:opts.cmd, "\<CR>"])
		endfunction

		let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
		let g:asyncrun_runner.floaterm = function('s:run_floaterm')
		let g:asynctasks_term_pos = 'floaterm'
		let g:asynctasks_term_focus = 0
	]])
end

function plugin.keybinds()

end

return function()
	Plugins.asynctasks.settings()
	TEMPMAP.plugin(Plugins.asynctasks)
end

