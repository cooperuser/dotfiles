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
		map.i("<right>", "<nop>") [[TEST TEST TEST]]
	end)

	map.group([[ctrl-[hjkl] Movement]], function()
		map.i("<C-k>", "<up>")
		map.i("<C-j>", "<down>")
		map.i("<C-h>", "<left>")
		map.i("<C-l>", "<right>")
	end)
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
		map.v("K", ":m '>+1<CR>gv=gv")
		map.v("J", ":m '<-2<CR>gv=gv")
	end)

	map.n("Q", "<nop>") [[The terrible Q]]
	map.i("<C-c>", "<ESC>") [[Allow ctrl-c to leave insert]]
	map.n("<C-p>", [["_ciw<C-o>P<ESC>]]) [[Replace word with clipboard]]
	map.sp("/", "<cmd>nohlsearch<CR>") [[Clear search highlighting]]
	-- }}}

	-- Terminal {{{
	map.t("<C-w>", [[<C-\><C-n><C-w>]]) [[Window movements in terminal mode]]
	map.t("<C-u>", [[<C-\><C-n><C-u>]]) [[Quickly scroll up in terminal mode]]
	-- }}}
end

return {
	keybinds = keybinds,
	binds = binds,
	map = map
}

