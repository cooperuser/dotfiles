#!/usr/bin/fish

function gh
	set CURRENT_DIRECTORY (pwd);
	cd ~/GitHub;
	set SELECTED_REPO (ls | fzf --preview="exa -T --color=always --git-ignore --ignore-glob='node_modules|build|out|dist|doc|bin|obj' {}");
	set error $status;
	if test $error -ne 130
		cd $SELECTED_REPO;
	else
		cd $CURRENT_DIRECTORY;
	end
	return $error
end

