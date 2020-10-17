#!/usr/bin/fish

function vot
	set CURRENT_DIRECTORY (pwd);
	cd ~/.config;
	set SELECTED_FILE (git ls-tree -r master --name-only | fzf --preview="bat --style=full --color=always {}");
	set error $status
	if test $status -ne 130
		$EDITOR $SELECTED_FILE;
	end
	cd $CURRENT_DIRECTORY;
	return $error
end

