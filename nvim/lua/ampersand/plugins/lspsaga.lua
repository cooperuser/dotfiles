return function()
	local saga = require("lspsaga")
	local diag = require("lspsaga.diagnostic")
	local rename = require("lspsaga.rename")
	local signature = require("lspsaga.signaturehelp")
	local hover = require("lspsaga.hover")
	local finder = require("lspsaga.provider")
	local code_action = require("lspsaga.codeaction")
	local action = require("lspsaga.action")

	saga.init_lsp_saga {
		use_saga_diagnostic_sign = false,
		code_action_icon = '  ',
		finder_definition_icon = '   ',
		finder_reference_icon = '   ',
		definition_preview_icon = '   ',
		code_action_prompt = {
			enable = false,
			sign = false,
			virtual_text = true
		}
	}

	-- 
	vim.fn.sign_define("LspSagaLightBulb", { text = "", texthl = "Folded" })

	K.q {"k", diag.lsp_jump_diagnostic_prev}
	K.q {"j", diag.lsp_jump_diagnostic_next}
	K.n {"[d", diag.lsp_jump_diagnostic_prev}
	K.n {"]d", diag.lsp_jump_diagnostic_next}
	K.n {"<M-k>", diag.lsp_jump_diagnostic_prev}
	K.n {"<M-j>", diag.lsp_jump_diagnostic_next}

	K.n {"gh", "K"}
	K.n {"K", hover.render_hover_doc}

	K.n {"gr", rename.rename}
	K.n {"gs", signature.signature_help}
	K.n {"gl", finder.lsp_finder}
	K.n {"gp", finder.preview_definition}
	K.n {"gd", vim.lsp.buf.definition}
	K.n {"<M-Return>", code_action.code_action}

	local function scroll(func)
		return function()
			if hover.has_saga_hover() then
				local id = vim.api.nvim_win_get_var(0, "lspsaga_hoverwin_data")[1]
				local win = vim.api.nvim_win_get_number(id)
				local cmd = win .. "windo call " .. func .. "()"
				vim.cmd(cmd)
			else
				vim.fn[func]()
			end
		end
	end

	K.n {"<C-d>", scroll("smoothie#downwards")}
	K.n {"<C-u>", scroll("smoothie#upwards")}
end
