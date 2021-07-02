return function()
	local sumneko_root_path = '~/.cache/yay/lua-language-server/src/lua-language-server'
	local sumneko_binary = "lua-language-server"
	local luadev = require("lua-dev").setup {
		lspconfig = {
			cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"}
		}
	}

	require("lspconfig").sumneko_lua.setup(luadev)
end
