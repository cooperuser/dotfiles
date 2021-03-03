return function()
	local saga = require("lspsaga")
	local diag = require("lspsaga.diagnostic")
	local rename = require("lspsaga.rename")
	local signature = require("lspsaga.signaturehelp")
	local hover = require("lspsaga.hover")
	local finder = require("lspsaga.provider")
	local action = require("lspsaga.codeaction")

	saga.init_lsp_saga{
		use_saga_diagnostic_sign = false,
		code_action_icon = '  ',
		finder_definition_icon = '   ',
		finder_reference_icon = '   ',
		definition_preview_icon = '   ',
	}

	K.q {"k", diag.lsp_jump_diagnostic_prev}
	K.q {"j", diag.lsp_jump_diagnostic_next}
	K.n {"[d", diag.lsp_jump_diagnostic_prev}
	K.n {"]d", diag.lsp_jump_diagnostic_next}
	K.n {"<M-k>", diag.lsp_jump_diagnostic_prev}
	K.n {"<M-j>", diag.lsp_jump_diagnostic_next}

	K.n {"gr", rename.rename}
	K.n {"gs", signature.signature_help}
	K.n {"gh", hover.render_hover_doc}
	K.n {"gl", finder.lsp_finder}
	K.n {"gp", finder.preview_definition}
	K.n {"<M-Return>", action.code_action}
end
