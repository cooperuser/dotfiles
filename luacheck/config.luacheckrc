stds.neovim = {
	globals = {
		"vim",
		"Plugins"
	},
	read_globals = {
		"K"
	}
}

std = "luajit"
files["**/nvim/**/*.lua"].std = "+neovim"

-- vim: filetype=lua

