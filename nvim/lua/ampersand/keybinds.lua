local function nnoremap(key, cmd, opts)
	vim.api.nvim_set_keymap('n', key, cmd, opts)
end

local function inoremap(key, cmd, opts)
	vim.api.nvim_set_keymap('i', key, cmd, opts)
end

local function keybinds()
	inoremap("<C-j>", "<down>", {})
	inoremap("<C-k>", "<up>", {})
	inoremap("<C-h>", "<left>", {})
	inoremap("<C-l>", "<right>", {})

	nnoremap("<C-j>", ":bprevious<CR>", {})
	nnoremap("<C-k>", ":bnext<CR>", {})
end

return {
	nnoremap = nnoremap,
	inoremap = inoremap,
	keybinds = keybinds
}

