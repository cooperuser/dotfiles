return function()
	local toggleterm = require("toggleterm")

	toggleterm.setup {
		shade_terminals = true;
		open_mapping = [[<M-Esc>]];
		-- size = 76;
		size = 12;
		direction = "horizontal";
		persist_size = true;
		float_opts = {
			width = 114;
			height = 28;
		};
		-- start_in_insert = false;
	}

	Plugins.toggleterm = {}
	function Plugins.toggleterm.enter()
		vim.api.nvim_win_set_option(0, "number", false)
		vim.api.nvim_win_set_option(0, "relativenumber", false)
		vim.api.nvim_win_set_option(0, "signcolumn", "no")


		-- vim.api.nvim_buf_set_keymap(0, "t", "<Leader>x", [[<C-\><C-n>]], {noremap = true})
		K.t {"<Leader>x", [[<C-\><C-n>3l]]}
		-- K.n {"<M-Tab>", [[<C-w>p]]}
		-- K.t {"<M-Tab>", [[<C-\><C-n><C-w>p]]}
		K.t {"<Esc>", [[<C-\><C-n>]]}
		K.t {"<C-w>", [[<C-\><C-n><C-w>]]}
		K.t {"<Leader><C-w>", [[<C-w>]]}
		-- K.t {"<Leader><Esc>", [[<Esc>]]}
		-- vim.api.nvim_buf_set_keymap(0, "t", "<C-c>", [[<C-\><C-n>]], {})
		-- vim.api.nvim_buf_set_keymap(0, "t", "<Leader><C-c>", "i<C-c>", {noremap = true})
	end

	vim.cmd [[autocmd TermEnter *toggleterm#* lua Plugins.toggleterm.enter()]]

	local binds = {"a", "s", "d", "f"}
	for i, k in ipairs(binds) do
		local bind = {"<Leader>" .. k, "<cmd>" .. i .. "ToggleTerm<CR>"}
		K.n(bind)
		K.t(bind)
	end
	-- K.n {"<C-t>", "<cmd>exe " .. vim.v.count1 .. "ToggleTerm<CR>", {
	-- 		silent = true,
	-- }}
end
