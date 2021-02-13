local plugin = {name = "compe"}
Plugins[plugin.name] = plugin

function plugin.settings()
	local compe = require("compe")

	compe.setup {
		enabled = true;
		autocomplete = true;
		debug = false;
		min_length = 1;
		preselect = "always";
		throttle_time = 80;
		source_timeout = 100;
		incomplete_delay = 400;
		max_abbr_width = 100;
		max_kind_width = 100;
		max_menu_width = 100;

		source = {
			path = true;
			buffer = true;
			calc = true;
			vsnip = true;
			nvim_lsp = true;
			nvim_lua = true;
			spell = true;
			tags = true;
			snippets_nvim = true;
			treesitter = false;
		};
	}

	vim.cmd("sign define LspDiagnosticsSignError text=▎")
	vim.cmd("sign define LspDiagnosticsSignWarning text=▎")
	vim.cmd("sign define LspDiagnosticsSignInformation text=▎")
	vim.cmd("sign define LspDiagnosticsSignHint text=▎")
end

function plugin.keybinds()
	vim.cmd("inoremap <silent><expr> <C-Space> compe#complete()")
	-- vim.cmd("inoremap <silent><expr> <CR>      compe#confirm('<CR>')")
	vim.cmd("inoremap <silent><expr> <CR>      compe#close('<CR>')")
	vim.cmd("inoremap <silent><expr> <tab>     compe#confirm('<tab>')")
	vim.cmd("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")
end

return function()
	Plugins.compe.settings()
	K.plugin(Plugins.compe)
end

