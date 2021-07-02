#!/usr/bin/fish

function jcl
	set CURRENT_DIRECTORY (pwd);
	cd ~/classes/2020-2021/spring;
	# set CLASSES (find -mindepth 2 -maxdepth 2 -type d);
	set SELECTED_REPO (find -mindepth 2 -maxdepth 2 -type d | fzf --preview="exa -T --color=always --git-ignore --ignore-glob='node_modules|build|out|dist|doc|bin|obj' {}");
	set error $status;
	if test $error -ne 130
		cd $SELECTED_REPO;
	else
		cd $CURRENT_DIRECTORY;
	end
	return $error
end

