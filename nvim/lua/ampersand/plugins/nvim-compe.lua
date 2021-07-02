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
		max_abbr_width = 32;
		max_kind_width = 100;
		max_menu_width = 100;
		sort = true;

		source = {
			path = true;
			buffer = false;
			calc = true;
			vsnip = true;
			luasnip = false;
			nvim_lsp = true;
			nvim_lua = true;
			spell = false;
			tags = true;
			snippets_nvim = false;
			ultisnips = false;
			treesitter = false;
			-- emoji = true;
			latex_symbols = true;
		};
	}

	vim.fn.sign_define("LspDiagnosticsSignError", {text="", numhl="LspDiagnosticsSignError"})
	vim.fn.sign_define("LspDiagnosticsSignWarning", {text="", numhl="LspDiagnosticsSignWarning"})
	vim.fn.sign_define("LspDiagnosticsSignInformation", {text="", numhl="LspDiagnosticsSignInformation"})
	vim.fn.sign_define("LspDiagnosticsSignHint", {text="", numhl="LspDiagnosticsSignHint"})
	-- }}}

	local kinds = vim.lsp.protocol.CompletionItemKind
	kinds[kinds.Snippet] = " "
	kinds[kinds.Keyword] = " "
	kinds[kinds.Function] = " "
	kinds[kinds.Variable] = " v"
	kinds[kinds.Property] = " p"
	kinds[kinds.Field] = " f"
	kinds[kinds.Text] = " "
	kinds[kinds.Class] = " "
	kinds[kinds.Method] = " "
	kinds[kinds.Module] = " "
	kinds[kinds.Constant] = " "
	kinds[kinds.Interface] = " "
	kinds[kinds.Struct] = " "
	kinds[kinds.Reference] = " "
	kinds[kinds.Enum] = "璉"
	kinds[kinds.EnumMember] = "• "
	--   

	-- local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, false)
	-- vim.g.lexima_no_default_rules = 1
	-- vim.fn["lexima#set_default_rules"]()

	-- local confirm = vim.fn["compe#confirm"]
	-- local expand = vim.fn["lexima#expand"]

	-- Keybinds {{{
	-- vim.g.lexima_no_default_rules = true
	-- vim.fn["lexima#set_default_rules"]()
	-- vim.cmd [[inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))]]
	vim.cmd [[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]]

	vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
	vim.cmd [[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]]
	vim.cmd [[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': +4 })]]
	vim.cmd [[inoremap <silent><expr> <C-u>     compe#scroll({ 'delta': -4 })]]
end
