local plugin = {name = "lspsaga"}
Plugins[plugin.name] = plugin

function plugin.settings()
	local saga = require("lspsaga")

	saga.init_lsp_saga{
		use_saga_diagnostic_sign = false,
		code_action_icon = '  ',
		finder_definition_icon = '   ',
		finder_reference_icon = '   ',
		definition_preview_icon = '   ',
		-- error_header = "   Error",
		-- warn_header = "   Warn",
		-- hint_header = "   Hint",
		-- infor_header = "   Infor"
	}
end

function plugin.keybinds()
	TEMPMAP.group([[Move between diagnostics]], function()
		TEMPMAP.sp("k", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		TEMPMAP.sp("j", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		TEMPMAP.n("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		TEMPMAP.n("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		TEMPMAP.n("<M-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		TEMPMAP.n("<M-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	end)
	TEMPMAP.n("gr", "<cmd>Lspsaga rename<CR>")
	TEMPMAP.n("gs", "<cmd>Lspsaga signature_help<CR>", {silent = false})
	TEMPMAP.i("<C-e>", "<C-e><cmd>Lspsaga signature_help<CR>")
	TEMPMAP.i("<C-g>", "<cmd>Lspsaga hover_doc<CR>")
	-- TEMPMAP.n("K", "<cmd>Lspsaga hover_doc<CR>")
	TEMPMAP.n("gd", "<cmd>Lspsaga preview_definition<CR>")
	TEMPMAP.n("gh", "<cmd>Lspsaga lsp_finder<CR>")
	TEMPMAP.n("g<Space>", "<cmd>Lspsaga hover_doc<CR>")
	TEMPMAP.n("<C-h>", "<cmd>lua vim.lsp.buf.hover()<CR>")
	TEMPMAP.n("<M-Return>", "<cmd>Lspsaga code_action<CR>")
end

return function()
	Plugins.lspsaga.settings()
	TEMPMAP.plugin(Plugins.lspsaga)
end

