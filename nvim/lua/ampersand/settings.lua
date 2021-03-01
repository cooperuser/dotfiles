require("tj.globals")
local opt = vim.opt

-- Appearance options {{{
opt.number = true
opt.relativenumber = true
-- opt.cursorline = true
opt.foldmethod = "marker"
opt.foldlevelstart = 1
vim.opt.guifont = [[Hack\ Nerd\ Font:h12]]
local a = "n-sm:block-Cursor,"
local b = "i-ci:ver25-CursorIM,"
local c = "r-cr:hor20-CursorRM,"
local d = "v-ve:ver25-CursorVM,"
local e = "c-o:block-CursorCM,"
opt.guicursor = a .. b .. c .. d .. e
-- }}}

-- Information options {{{
opt.colorcolumn = 80
opt.signcolumn = "yes:1"
opt.showmode = false
opt.showcmd = true
opt.shortmess = vim.api.nvim_get_option("shortmess") .. "c"
opt.undofile = true
opt.swapfile = false
-- }}}

-- Window/buffer options {{{
opt.laststatus = 2
opt.showtabline = 2
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.visualbell = true
opt.gdefault = true
-- }}}

-- Text options {{{
opt.scrolloff = 99
opt.wrap = false
opt.listchars = [[tab:🭰\ ,trail:▓]]
opt.fillchars = [[fold:\ ,eob:\ ]]
opt.list = true
opt.formatoptions = "jql"
opt.clipboard = "unnamedplus"
opt.inccommand = "nosplit"
vim.cmd("autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()")
-- }}}

-- Movement options {{{
opt.whichwrap = opt.whichwrap + "<,>,h,l,[,]"
vim.cmd("autocmd InsertLeave * normal `^")
-- }}}

-- Indenting options {{{
opt.autoindent = true
opt.smartindent = true
opt.expandtab = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
-- }}}

-- PUM options {{{
opt.pumheight = 16
opt.pumblend = 15
opt.winblend = 15
-- }}}

-- Search options {{{
opt.selection = "exclusive"
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = "menu,menuone,noselect"
-- }}}

-- Timing options {{{
opt.timeoutlen = 1000
opt.ttimeoutlen = 0
-- }}}

-- Color options {{{
opt.termguicolors = true
vim.cmd("syntax on")
-- }}}

