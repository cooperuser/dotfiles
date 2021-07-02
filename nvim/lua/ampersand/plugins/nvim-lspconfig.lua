return function()
	local lspconfig = require("lspconfig")
	local linters = require("ampersand.linters")

	local on_attach = function()
		require("illuminate").on_attach()
		require("lsp_signature").on_attach()
	end

	local system_name
	if vim.fn.has("mac") == 1 then
		system_name = "macOS"
	elseif vim.fn.has("unix") == 1 then
		system_name = "Linux"
	elseif vim.fn.has('win32') == 1 then
		system_name = "Windows"
	else
		print("Unsupported system for sumneko")
	end

	local sumneko_root_path = '~/.cache/yay/lua-language-server/src/lua-language-server'
	local sumneko_binary = "lua-language-server"
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}

	lspconfig.tsserver.setup{}
	lspconfig.vimls.setup{}
	lspconfig.texlab.setup{
		filetypes = { "tex", "bib", "markdown" };
		capabilities = capabilities;
		settings = {
			latex = {
				build = {
					onSave = true
				}
			}
		}
	}
	lspconfig.pyright.setup{}
	-- lspconfig.html.setup{capabilities = capabilities}
	lspconfig.cssls.setup{}
	lspconfig.jsonls.setup{
		settings = {
			json = {
				schemas = {
					{
						fileMatch = {"package.json"},
						url = "https://json.schemastore.org/package"
					},
					{
						fileMatch = {"tsconfig.json"},
						url = "https://json.schemastore.org/tsconfig"
					}
				}
			}
		}
	}
	-- lspconfig.sumneko_lua.setup{
	-- 	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	-- 	on_attach = on_attach,
	-- 	settings = {
	-- 		Lua = {
	-- 			telemetry = {
	-- 				enable = false,
	-- 			},
	-- 			completion = {
	-- 				workspaceWord = false
	-- 			},
	-- 			diagnostics = {
	-- 				globals = {'vim', 'use', "shout"},
	-- 				disable = {"undefined-global"}
	-- 			},
	-- 			hint = {
	-- 				enable = true,
	-- 				setType = true
	-- 			},
	-- 			workspace = {
	-- 				preloadFileSize = 150,
	-- 				library = {
	-- 					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
	-- 					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
	-- 					[vim.fn.expand('~/.local/share/nvim/site/pack/packer/start')] = true,
	-- 				},
	-- 			},
	-- 		}
	-- 	}
	-- }
	lspconfig.clangd.setup{on_attach = on_attach}
	lspconfig.elixirls.setup{cmd = {"elixir-ls"}}
	lspconfig.hls.setup{}
	lspconfig.rust_analyzer.setup{
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				completion = {
					postfix = {
						enable = false
					}
				},
				lens = {
					enable = true,
					methodReferences = true,
					references = true,
				},
				diagnostics = {
					enable = true,
					-- disabled = {"unresolved-proc-macro"},
					disabled = {"dead-code", "dead_code"},
					enableExperimental = true,
				},
			}
		}
	}
	lspconfig.diagnosticls.setup {
		filetypes = {"c", "markdown"},
		init_options = {
			linters = linters,
			filetypes = {
				c = "cpplint",
				markdown = {"markdownlint", "write-good"}
			}
		}
	}
	lspconfig.java_language_server.setup {
		cmd = {"/usr/bin/java-language-server"}
	}
	lspconfig.leanls.setup {}

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			update_in_insert = true,
		}
	)

	vim.lsp.handlers['textDocument/hover'] = require'lspsaga.hover'.render_hover_doc
end
