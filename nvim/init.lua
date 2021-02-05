                                    --[[--
                                                                           __
  _______  ___  ___  ___ ___________ ___ _  ___  ___ _______ ___ ____  ___/ /
 / __/ _ \/ _ \/ _ \/ -_) __/___/ _ `/  ' \/ _ \/ -_) __(_-</ _ `/ _ \/ _  /
 \__/\___/ .__/ .__/\__/_/      \_,_/_/_/_/ .__/\__/_/ /___/\_,_/_//_/\_,_/
        /_/  /_/                         /_ /

                                    --]]--
-- luacheck: new_globals K

vim.g.mapleader = ","

local keybinds = require("ampersand.keybinds")
keybinds.keybinds()
K = keybinds.map
require("ampersand.plugins")
require("ampersand.settings")

vim.cmd("source ~/.config/nvim/config/statusline.vim")
vim.cmd("colorscheme glowbeam")

