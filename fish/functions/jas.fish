#!/usr/bin/fish

function jas
	# set ASSIGNMENTS (find -mindepth 2 -maxdepth 2 -type d);
	set SELECTED_REPO (find -mindepth 2 -maxdepth 2 -type d | fzf --preview="exa -T --color=always --git-ignore --ignore-glob='node_modules|build|out|dist|doc|bin|obj|.git' {}");
	set error $status;
	if test $error -ne 130
		cd $SELECTED_REPO;
	end
	return $error
end

