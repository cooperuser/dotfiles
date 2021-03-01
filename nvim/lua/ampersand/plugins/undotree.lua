local plugin = {name = "undotree"}
Plugins[plugin.name] = plugin

function plugin.load()
	-- vim.api.nvim_win_set_option(0, "winhl", "Constant:Normal")
end

function plugin.settings()
	vim.g.undotree_WindowLayout = 3
	vim.g.undotree_DiffAutoOpen = false
	vim.g.undotree_SetFocusWhenToggle = true
	vim.g.undotree_ShortIndicators = true
	vim.g.undotree_SplitWidth = 32

	vim.g.undotree_TreeNodeShape = '•'

	vim.cmd("autocmd FileType undotree lua Plugins.undotree.load()")
end
function plugin.keybinds()
	K.sp("u", "<cmd>UndotreeToggle<CR>")
	-- K.n("<Tab>", "<cmd>UndotreeToggle<CR>")
end

return function()
	Plugins.undotree.settings()
	K.plugin(Plugins.undotree)
end

