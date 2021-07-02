                                    --[[--
                                                                           __
  _______  ___  ___  ___ ___________ ___ _  ___  ___ _______ ___ ____  ___/ /
 / __/ _ \/ _ \/ _ \/ -_) __/___/ _ `/  ' \/ _ \/ -_) __(_-</ _ `/ _ \/ _  /
 \__/\___/ .__/ .__/\__/_/      \_,_/_/_/_/ .__/\__/_/ /___/\_,_/_//_/\_,_/
        /_/  /_/                         /_ /

                                    --]]--
-- luacheck: new_globals TEMPMAP

vim.g.mapleader = ","

function P(o) print(vim.inspect(o)) return o end
local keybinds = require("ampersand.keybinds")
K = require("ampersand.keymap")
keybinds.keybinds()
TEMPMAP = keybinds.map
require("ampersand.plugins")
require("ampersand.settings")

vim.cmd("colorscheme glowbeam")

vim.g.peekaboo_delay = 1000
