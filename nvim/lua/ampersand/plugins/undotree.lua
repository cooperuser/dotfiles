return function()
	vim.g.undotree_WindowLayout = 3
	vim.g.undotree_DiffAutoOpen = false
	vim.g.undotree_SetFocusWhenToggle = true
	vim.g.undotree_ShortIndicators = true
	vim.g.undotree_SplitWidth = 32

	vim.g.undotree_TreeNodeShape = '•'

	K.q {"u", "<cmd>UndotreeToggle<CR>"}
end
