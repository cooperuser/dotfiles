-- luacheck: new_globals K

vim.g.mapleader = ","

local keybinds = require("ampersand.keybinds")
keybinds.keybinds()
K = keybinds.map
require("ampersand.plugins")
require("ampersand.settings")

vim.cmd("source ~/.config/nvim/config/bufline.vim")
vim.cmd("source ~/.config/nvim/config/statusline.vim")

vim.cmd("colorscheme glowbeam")

