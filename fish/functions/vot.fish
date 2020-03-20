#!/usr/bin/fish

function vot
	set CURRENT_DIRECTORY (pwd);
	cd ~/.config;
	set SELECTED_FILE (fzf --preview="bat --style=numbers --color=always {}" --query="!nvim/plugged ");
	set error $status
	if test $status -ne 130
		$EDITOR $SELECTED_FILE;
	end
	cd $CURRENT_DIRECTORY;
	return $error
end

