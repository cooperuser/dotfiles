function set_git_changes
	set branch (git branch ^/dev/null | grep \* | sed 's/* //')
	if test -n "$branch"
		set remote (git config "branch.$branch.remote")
		if test -n "$remote"
			set merge_branch (git config branch.$branch.merge | cut -d / -f 3)
			set rev_list (git rev-list --left-right --count "$branch"..."$remote/$merge_branch")
			set changes (string split \t $rev_list)
			if test $changes[1] -ne 0 -o $changes[2] -ne 0
				set -g git_changes $changes
			else
				set -g git_changes
			end
		end
	end
end

