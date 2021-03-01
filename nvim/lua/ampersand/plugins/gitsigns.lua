local plugin = {name = "gitsigns"}
Plugins[plugin.name] = plugin

function plugin.settings()
	require('gitsigns').setup {
		signs = {
			add          = {hl = 'GitGutterAdd'   , text = '▎', numhl='GitSignsAddNr'},
			change       = {hl = 'GitGutterChange', text = '▎', numhl='GitSignsChangeNr'},
			delete       = {hl = 'GitGutterDelete', text = '‣', numhl='GitSignsDeleteNr'},
			topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr'},
			changedelete = {hl = 'GitGutterChangeDelete', text = '~', numhl='GitSignsChangeNr'},
		}
	}
end

function plugin.keybinds()
	K.n("<Leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>")
	K.n("<Leader>gb", "<cmd>lua require('gitsigns').blame_line()<CR>")
	K.n("<Leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<CR>")
	K.n("<Leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>")
	K.n("<Leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>")
end

return function()
	Plugins.gitsigns.settings()
	K.plugin(Plugins.gitsigns)
end

