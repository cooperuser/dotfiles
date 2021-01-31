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
		K.sp("k", "<cmd>LspSagaDiagJumpPrev<CR>")
		K.sp("j", "<cmd>LspSagaDiagJumpNext<CR>")
		K.n("[d", "<cmd>LspSagaDiagJumpPrev<CR>")
		K.n("]d", "<cmd>LspSagaDiagJumpNext<CR>")
	end)
	K.n("gr", "<cmd>LspSagaRename<CR>")
	K.n("gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", {silent = false})
	K.n("K", "<cmd>LspSagaHoverDoc<CR>")
	K.n("gd", "<cmd>LspSagaDefPreview<CR>")
	K.n("gh", "<cmd>LspSagaFinder<CR>")
	K.n("<M-Return>", "<cmd>LspSagaCodeAction<CR>")
end

return function()
	Plugins.lspsaga.settings()
	K.plugin(Plugins.lspsaga)
end

