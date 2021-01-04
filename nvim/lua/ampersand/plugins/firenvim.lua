local plugin = {name = "firenvim"}
Plugins[plugin.name] = plugin

local unfocus = "setTimeout(() => {document.activeElement.blur()}, 0)"

function plugin.onEnter()
	if vim.g.started_by_firenvim then
		if vim.api.nvim_get_option("lines") < 5 then
			vim.opt.laststatus = 0
			vim.opt.number = false
			vim.opt.relativenumber = false
			vim.opt.signcolumn = "no"
			vim.cmd("startinsert")
		end
		vim.opt.showtabline = 0
		vim.opt.wrap = true
		vim.opt.linebreak = true

		K.n("<C-h>", "<cmd>lua Plugins.firenvim.onHide()<CR>")
		vim.cmd("autocmd VimLeave * lua Plugins.firenvim.onLeave()")
	end
end

function plugin.onLeave()
	vim.fn["firenvim#eval_js"](unfocus)
end

function plugin.onHide()
	vim.fn["firenvim#hide_frame"]()
	plugin.onLeave()
end

function plugin.filename(raw)
	local t = {}
	local i = 1
	for v in string.gmatch(raw, "([^%s_]+)[_$]") do
		t[i] = v
		i = i + 1
	end
	return t[1]
end

function plugin.settings()
	vim.g.firenvim_config = {
		localSettings = {
			[".*"] = {
				takeover = "never"
			}
		}
	}

	vim.cmd("autocmd UIEnter * lua Plugins.firenvim.onEnter()")
end

function plugin.keybinds()

end

return function()
	Plugins.firenvim.settings()
	K.plugin(Plugins.firenvim)
end

