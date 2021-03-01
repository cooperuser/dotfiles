local plugin = {name = "codi"}
Plugins[plugin.name] = plugin

function plugin.create()
	vim.api.nvim_win_set_option(0, "fillchars", "eob: ")
	vim.cmd("file " .. vim.g["codi#filetype"])
end

function plugin.settings()
	vim.g["codi#virtual_text"] = false
	vim.g["codi#rightsplit"] = false
	vim.g["codi#autoclose"] = false
	vim.cmd("autocmd FileType codi lua Plugins.codi.create()")
end

function plugin.keybinds()
	K.sp("C", "<cmd>let g:codi#filetype=&filetype<CR><cmd>Codi!!<CR>")
end

return function()
	Plugins.codi.settings()
	K.plugin(Plugins.codi)
end

