return function()
	local signature = require("lsp_signature")
	signature.on_attach {
		doc_lines = 10,
		hint_enable = true,
		hint_scheme = "CursorLineNr",
		use_lspsaga = false
	}

	K.n { "sg", vim.lsp.buf.signature_help }
end
