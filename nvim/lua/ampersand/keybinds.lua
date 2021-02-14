-- The K (keybind) namespace should be loaded globally
-- Set keybinds by using `K.<mode>(<key>, <cmd>, <opts>)`
-- The keybind can be annotated by adding a string:
--     K.i(...) [[This is an annotation]]

-- Declarations {{{
local binds = {}
local data = {
	plugin = nil,
	comment = nil,
	group = nil
}

local function wrapper(mode, prefix, args)
	args = args or {}
	if args.noremap == nil then args.noremap = true end

	---@param key string Keymap trigger
	---@param cmd string Command to run
	---@param opts table Options [optional]
	local function noremap(key, cmd, opts)
		if opts then
			if opts.map then
				opts.map = nil
				opts.noremap = false
			end
			for k, v in pairs(opts) do args[k] = v end
		end

		local full = key
		if prefix then full = prefix .. key end

		local keyPath = mode .. '_' .. full

		binds[keyPath] = {
			mode = mode,
			prefix = prefix,
			key = key,
			cmd = cmd,
			args = args,
			plugin = data.plugin,
			comment = data.comment,
			group = data.group
		}

		vim.api.nvim_set_keymap(mode, full, cmd, args)

		return function(comment)
			binds[keyPath].comment = comment
		end
	end

	return noremap
end

local function group(name, keybinds)
	data.group = name
	if keybinds then
		keybinds()
		data.group = nil
	end
end

local function plugin(p)
	data.plugin = p.name
	if p.keybinds then p.keybinds() end
	data.plugin = nil
end

local map = {
	i = wrapper('i'),
	n = wrapper('n'),
	v = wrapper('v'),
	t = wrapper('t'),
	c = wrapper('c'),
	sp = wrapper('n', "<space>", {silent = true}),
	group = group,
	plugin = plugin
}
-- }}}

local function keybinds()
	-- Movement {{{
	map.group([[Disable arrow keys]], function()
		map.n("<up>", "<nop>")
		map.n("<down>", "<nop>")
		map.n("<left>", "<nop>")
		map.n("<right>", "<nop>")
		map.i("<up>", "<nop>")
		map.i("<down>", "<nop>")
		map.i("<left>", "<nop>")
		map.i("<right>", "<nop>")
	end)

	map.group([[Swap 0 and ^ (possibly temporary)]], function()
		function MoveZero()
			local line = vim.api.nvim_get_current_line()
			local cursor = vim.api.nvim_win_get_cursor(0)
			if line:sub(cursor[2], cursor[2]) == "\t" then
				-- vim.api.nvim_win_set_cursor(cursor[1], 0)
				vim.api.nvim_feedkeys("0", "n", true)
			else
				vim.api.nvim_feedkeys("^", "n", true)
			end
		end
		map.n("0", "<cmd>lua MoveZero()<CR>")
		map.n("^", "0")
	end)

	map.group([[ctrl-[hjkl] Movement]], function()
		map.i("<C-k>", "<up>")
		map.i("<C-j>", "<down>")
		map.i("<C-h>", "<left>")
		map.i("<C-l>", "<right>")
	end)

	map.n("<Leader>;", ",")
	-- }}}

	-- Buffers {{{
	map.group([[Move between buffers]], function()
		map.n("<C-k>", "<cmd>bnext<CR>")
		map.n("<C-j>", "<cmd>bprevious<CR>")
	end)

	map.group([[Create/delete buffers]], function()
		map.sp("b", "<cmd>ene<CR>")
		map.sp("B", "<cmd>bd<CR>")
	end)

	map.group([[Create/delete tabs]], function()
		map.sp("gt", "<cmd>tabnew<CR>")
		map.sp("gT", "<cmd>tabclose<CR>")
	end)

	map.group([[Move to last buffer]], function()
		map.n("<C-z>", "<C-^>")
		map.i("<C-z>", "<C-o><C-^>")
		map.t("<C-z>", [[<C-\><C-n><C-^>]])
	end)
	-- }}}

	-- Quality of life {{{
	map.group([[Make `c` not affect clipboard]], function()
		map.n("c", [["_c]])
		map.n("C", [["_C]])
		map.v("c", [["_c]])
	end)

	map.group([[Shift lines in visual mode]], function()
		map.v("K", ":m '<-2<CR>gv=gv")
		map.v("J", ":m '>+1<CR>gv=gv")
	end)

	map.n("Q", "<nop>") [[The terrible Q]]
	map.i("<C-c>", "<ESC>") [[Allow ctrl-c to leave insert]]
	map.n("<C-p>", [["_ciw<C-o>P<ESC>]]) [[Replace word with clipboard]]
	map.sp("/", "<cmd>nohlsearch | echo<CR>") [[Clear search and cmd]]
	map.n("yif", "ggyG``") [[Yank whole file]]
	map.n("y0", "my^y$`y") [[Yank line without newline]]
	map.n("=if", "gg=G``") [[Reindent whole file]]
	map.sp("N", "<cmd>set number! relativenumber!<CR>") [[Toggle line numbers]]
	map.sp("<tab>", "<cmd>set noexpandtab tabstop=4 shiftwidth=4<CR>") [[Indents]]

	map.sp("s", "<cmd>silent w | luafile %<CR>") [[Run current lua file]]

	map.i("<M-h>", "<C-o>^") [[Move to beginning of line]]
	map.i("<M-l>", "<C-o>$") [[Move to end of line]]
	map.i("<M-j>", "<C-o>b") [[Move to last word]]
	map.i("<M-k>", "<C-o>w") [[Move to next word]]
	map.i("<M-o>", "<C-o>o") [[Move to end of line]]
	map.i("<M-O>", "<C-o>O") [[Move to end of line]]

	map.n("*", "*``", {map = true}) [[Highlight word without moving]]
	map.c("%s", "%sm") [[Highlight word without moving]]

	map.i("<C-b>", "<C-k>") [[Remap for digraph input]]

	map.i("<C-q>", [[<Esc>F "qx"qpgi]])
	map.i("<C-f>", [[<Esc>ge"qx"qpgi]])
	-- }}}

	-- Terminal {{{
	map.t("<C-w>", [[<C-\><C-n><C-w>]]) [[Window movements in terminal mode]]
	map.t("<C-u>", [[<C-\><C-n><C-u>]], {map=true})
	[[Quickly scroll up in terminal mode]]
	-- }}}

	-- MultiRun() {{{
	function MultiRun()
		local filetype = vim.api.nvim_buf_get_option(0, "syntax")

		if filetype == "markdown" then
			vim.cmd("MarkdownPreview")
		elseif filetype == "tex" then
			vim.cmd("VimtexCompile")
			map.sp("v", "<cmd>VimtexView<CR>")
		end
	end

	map.sp("c", "<cmd>lua MultirunRun()<CR>")
	-- }}}
end

return {
	keybinds = keybinds,
	binds = binds,
	map = map
}

