K = require("ampersand.keybinds")
K.keybinds()
require("ampersand.plugins")
require("ampersand.settings")

vim.cmd("source ~/.config/nvim/config/bufline.vim")
vim.cmd("source ~/.config/nvim/config/statusline.vim")

vim.cmd("colorscheme glowbeam")

