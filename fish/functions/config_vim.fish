#!/usr/bin/fish

function config_vim
	set CURRENT_DIRECTORY (pwd);
	cd ~/.config/nvim;
	vim ~/.config/nvim/init.vim ~/.config/nvim/config/plugins.vim ~/.config/nvim/config/settings.vim ~/.config/nvim/config/keybinds.vim ~/.config/nvim/config/statusline.vim ~/.config/nvim/config/bufline.vim -c 'bp | bn'
	cd $CURRENT_DIRECTORY;
end
