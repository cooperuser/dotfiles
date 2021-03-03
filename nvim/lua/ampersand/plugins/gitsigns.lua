return function()
	-- Utility {{{
	local gitsigns = require("gitsigns")
	-- }}}

	-- Settings {{{
	require('gitsigns').setup {
		signs = {
			add = {
				hl = "GitGutterAdd";
				numhl = "GitSignsAddNr";
				text = "▎";
			};
			change = {
				hl = "GitGutterChange";
				numhl = "GitSignsChangeNr";
				text = "▎";
			};
			delete = {
				hl = "GitGutterDelete";
				numhl = "GitSignsDeleteNr";
				text = "‣";
			};
			topdelete = {
				hl = "GitGutterDelete";
				numhl = "GitSignsDeleteNr";
				text = "‾";
			};
			changedelete = {
				hl = "GitGutterChangeDelete";
				numhl = "GitSignsChangeNr";
				text = "~";
			};
		}
	}
	-- }}}

	-- Keybinds {{{
	K.n {"<Leader>gp", gitsigns.preview_hunk}
	K.n {"<Leader>gb", gitsigns.blame_line}
	K.n {"<Leader>gs", gitsigns.stage_hunk}
	K.n {"<Leader>gu", gitsigns.undo_stage_hunk}
	K.n {"<Leader>gr", gitsigns.reset_hunk}
	-- }}}
end
