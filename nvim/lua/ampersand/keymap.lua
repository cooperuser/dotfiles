local tj = require("tj.keymap")
local keymap = {tj = tj}

-- class Mapping definition {{{

---@class Mapping @parent class
---@field public noremap boolean @default true
---@field public silent boolean @default false
---@field public script boolean @default false
---@field public expr boolean @default false
---@field public nowait boolean @default false
---@field public unique boolean @default false
local Mapping = {}

-- }}}

-- :nnoremap {{{

---@param opts Mapping
-- # Helper method for `:nnoremap`
-- [[Applies to]]
-- - Normal mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.n(opts)
	tj.nnoremap(opts)
	print(opts.noremap)
end

-- }}}
-- :vnoremap {{{

---@param opts Mapping
-- # Helper method for `:vnoremap`
-- [[Applies to]]
-- - Visual mode
-- - Select mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.v(opts) tj.vnoremap(opts) end

-- }}}
-- :xnoremap {{{

---@param opts Mapping
-- # Helper method for `:xnoremap`
-- [[Applies to]]
-- - Visual mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.x(opts) tj.xnoremap(opts) end

-- }}}
-- :onoremap {{{

---@param opts Mapping
-- # Helper method for `:onoremap`
-- [[Applies to]]
-- - Operator-pending mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.o(opts) tj.onoremap(opts) end

-- }}}
-- :inoremap {{{

---@param opts Mapping
-- # Helper method for `:inoremap`
-- [[Applies to]]
-- - Insert mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.i(opts) tj.inoremap(opts) end

-- }}}
-- :lnoremap {{{

---@param opts Mapping
-- # Helper method for `:lnoremap`
-- [[Applies to]]
-- - Insert mode
-- - Command-line mode
-- - Lang-Arg mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.l(opts) tj.lnoremap(opts) end

-- }}}
-- :cnoremap {{{

---@param opts Mapping
-- # Helper method for `:cnoremap`
-- [[Applies to]]
-- - Command-line mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.c(opts) tj.cnoremap(opts) end

-- }}}
-- :tnoremap {{{

---@param opts Mapping
-- # Helper method for `:tnoremap`
-- [[Applies to]]
-- - Terminal mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.t(opts) tj.tnoremap(opts) end

-- }}}
-- :qnoremap {{{

---@param opts Mapping
-- # Helper method for custom quick maps, `<Space>{...}`
-- [[Applies to]]
-- - Normal mode
-- [[Parameters]]
-- - opts (table): A table with keys:
--   - [1] = left hand side: Must be a string
--   - [2] = right hand side: Can be a string OR a lua function
--   - Other keys can be arguments to |:map|. See |nvim_set_keymap()|
function keymap.q(opts)
	opts[1] = "<Space>" .. opts[1]
	tj.nnoremap(opts)
end

-- }}}

return keymap

-- vim: foldmethod=marker foldlevel=0
