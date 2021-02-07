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
		error_header = "   Error",
		warn_header = "   Warn",
		hint_header = "   Hint",
		infor_header = "   Infor"
	}
end

function plugin.keybinds()
	K.group([[Move between diagnostics]], function()
		K.sp("k", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		K.sp("j", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		K.n("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		K.n("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	end)
	K.n("gr", "<cmd>Lspsaga rename<CR>")
	K.n("gs", "<cmd>Lspsaga signature_help<CR>", {silent = false})
	K.i("<C-e>", "<C-e><cmd>Lspsaga signature_help<CR>")
	K.i("<C-g>", "<cmd>Lspsaga hover_doc<CR>")
	-- K.n("K", "<cmd>Lspsaga hover_doc<CR>")
	K.n("gd", "<cmd>Lspsaga preview_definition<CR>")
	K.n("gh", "<cmd>Lspsaga lsp_finder<CR>")
	K.n("g<Space>", "<cmd>Lspsaga hover_doc<CR>")
	K.n("<M-Return>", "<cmd>Lspsaga code_action<CR>")
end

return function()
	Plugins.lspsaga.settings()
	K.plugin(Plugins.lspsaga)
end

