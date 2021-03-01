local plugin = {name = "lspconfig"}
Plugins[plugin.name] = plugin

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

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

function plugin.settings()
	local lspconfig = require("lspconfig")

	lspconfig.tsserver.setup{}
	lspconfig.vimls.setup{}
	lspconfig.texlab.setup{
		settings = {
			latex = {
				build = {
					onSave = true
				}
			}
		}
	}
	lspconfig.pyright.setup{}
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.html.setup{capabilities = capabilities}
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
	lspconfig.sumneko_lua.setup{
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
		settings = {
			Lua = {
				completion = {
					workspaceWord = false
				},
				diagnostics = {
					globals = {'vim', 'use', "shout"},
					disable = {"undefined-global"}
				},
				workspace = {
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
						[vim.fn.expand('~/.local/share/nvim/site/pack/packer/start')] = true,
					},
				},
			}
		}
	}
	lspconfig.clangd.setup{}
	lspconfig.elixirls.setup{cmd = {"elixir-ls"}}
	lspconfig.hls.setup{}

	vim.lsp.handlers['textDocument/hover'] = require'lspsaga.hover'.render_hover_doc
end

function plugin.keybinds()

end

return function()
	Plugins.lspconfig.settings()
	TEMPMAP.plugin(Plugins.lspconfig)
end

