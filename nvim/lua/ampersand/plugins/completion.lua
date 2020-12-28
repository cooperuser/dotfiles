local plugin = {name = "completion"}
Plugins[plugin.name] = plugin

function plugin.settings()
	local lspconfig = require("lspconfig")
	local completion = require("completion")

	local function attach()
		return completion.on_attach()
	end

	lspconfig.sumneko_lua.setup{on_attach=attach}
	lspconfig.vimls.setup{on_attach=attach}
	lspconfig.pyright.setup{on_attach=attach}
	lspconfig.tsserver.setup{on_attach=attach}
	lspconfig.rust_analyzer.setup{on_attach=attach}
	lspconfig.texlab.setup{on_attach=attach}
	lspconfig.clangd.setup{on_attach=attach}
	lspconfig.julials.setup{on_attach=attach}
	require('nlua.lsp.nvim').setup(lspconfig, {
			on_attach=attach,
			globals = {"Color", "c", "Group", "g", "s",}
		})
	require('gitsigns').setup({
			signs = {
				add          = {hl = 'GitGutterAdd'   , text = '▏', numhl='GitSignsAddNr'},
				change       = {hl = 'GitGutterChange', text = '▏', numhl='GitSignsChangeNr'},
				delete       = {hl = 'GitGutterDelete', text = '‣', numhl='GitSignsDeleteNr'},
				topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr'},
				changedelete = {hl = 'GitGutterChangeDelete', text = '~', numhl='GitSignsChangeNr'},
			}
		})

	vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
	vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
	vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
	vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
	vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
	vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
	vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
	vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

	vim.g.completion_customize_lsp_label = {
		Text = "ﮜ ",
		Variable = " ",
		Field = " ",
		Enum = "פּ ",
		EnumMember = " ",
		Class = " ",
		Method = " ",
		Function = " ",
		Property = " ",
		UltiSnips = " ",
		Snippet = " ",
		Module = " ",
		Keyword = " ",
		Constant = " ",
		Interface = " ",
		Struct = " ",
		Reference = " "
	}
	-- vim.g.completion_customize_lsp_label = {
	-- 	Text = "ﮜ [text]",
	-- 	Variable = " [variable]",
	-- 	Field = " [Field]",
	-- 	Enum = "פּ [enum]",
	-- 	Class = " [class]",
	-- 	Method = " [method]",
	-- 	Function = " [function]",
	-- 	Property = " [property]",
	-- 	UltiSnips = " [snippet]",
	-- 	Module = " [module]",
	-- 	Keyword = " [keyword]",
	-- 	Constant = " [constant]"
	-- }

	vim.g.completion_chain_complete_list = {
		default = {
			default = {
				{complete_items = {"lsp", "snippet"}},
				{complete_items = {"path"}},
				{mode = "<C-p>"},
				{mode = "<C-n>"}
			}
		}
	}

	vim.g.completion_sorting = "length"
	vim.g.completion_matching_strategy_list = { 
		'fuzzy', 'exact', 'substring', 'all'
	}

	-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	--   vim.lsp.diagnostic.on_publish_diagnostics, {
	--     update_in_insert = true,
	--   }
	-- )

	vim.api.nvim_exec([[
	sign define LspDiagnosticsSignError text=▎
	sign define LspDiagnosticsSignWarning text=▎
	sign define LspDiagnosticsSignInformation text=▎
	sign define LspDiagnosticsSignHint text=▎
]], true)

	function GetStatusNumbers()
		local error = vim.lsp.diagnostic.get_count(0, [[Error]])
		local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
		local information = vim.lsp.diagnostic.get_count(0, [[Information]])
		local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])
		return {error, warning, information, hint}
	end
end

function plugin.keybinds()
	K.group([[Move between diagnostics]], function()
		K.sp("k", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
		K.sp("j", ":lua vim.lsp.diagnostic.goto_next()<CR>")
	end)

	K.group([[Bring up code action menu]], function()
		K.n("<C-space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		K.i("<C-space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	end)
end

return function()
	Plugins.completion.settings()
	K.plugin(Plugins.completion)
end

