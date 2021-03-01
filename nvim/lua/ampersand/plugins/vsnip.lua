local plugin = {name = "vsnip"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
end

function plugin.keybinds()
	vim.cmd [[inoremap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<right>']]
	vim.cmd [[snoremap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<right>']]
	vim.cmd [[inoremap <expr> <C_h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<left>']]
	vim.cmd [[snoremap <expr> <C_h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<left>']]
end

return function()
	Plugins.vsnip.settings()
	TEMPMAP.plugin(Plugins.vsnip)
end

