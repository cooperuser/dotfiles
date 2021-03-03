return function()
	local compe = require("compe")

	-- Settings {{{
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
			snippets_nvim = false;
			ultisnips = false;
			treesitter = false;
		};
	}

	vim.fn.sign_define("LspDiagnosticsSignError", {text="", numhl="LspDiagnosticsSignError"})
	vim.fn.sign_define("LspDiagnosticsSignWarning", {text="", numhl="LspDiagnosticsSignWarning"})
	vim.fn.sign_define("LspDiagnosticsSignInformation", {text="", numhl="LspDiagnosticsSignInformation"})
	vim.fn.sign_define("LspDiagnosticsSignHint", {text="", numhl="LspDiagnosticsSignHint"})
	-- }}}

	-- Keybinds {{{
	-- K.i {"<C-Space>", compe._complete}
	-- K.i {"<CR>", function () compe._confirm_pre("<CR>") end}
	-- K.i {"<C-e>", function () compe._close("<C-e>") end}
	-- }}}
end
