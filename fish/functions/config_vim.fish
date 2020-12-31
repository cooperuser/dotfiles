#!/usr/bin/fish

function config_vim
	set CURRENT_DIRECTORY (pwd);
	cd ~/.config/nvim;
	vim init.lua lua/ampersand/plugins.lua lua/ampersand/settings.lua lua/ampersand/keybinds.lua -c 'bp | bn'
	cd $CURRENT_DIRECTORY;
end

