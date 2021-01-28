set charPrompt "&"
set charArrowPass "‣"
set charArrowFail "×"
set charArrowTerm "■"

# 🞅●◒◓⯋⯊
set charGitBehind "◒"
set charGitAhead "◓"
set charGitBoth "●"

set customRed    (set_color ff6c6b)
set customOrange (set_color f2c68a)
set customYellow (set_color cae682)
set customGreen  (set_color 95e454)
set customBlue   (set_color 87afff)
set customPurple (set_color B7D)
set customCopper (set_color FFAA22)
set customMuted  (set_color aaa)

# set colorUser (set_color FA2)
# set colorAt   (set_color 9C5)
# set colorHost (set_color 3Af)

function fish_prompt
	set error $status
	set charUser "&"

	set colorTime   $customOrange
	set colorPath   $customBlue
	set colorArrow  $customGreen
	set colorChar   $customCopper
	set colorError  $customRed
	set colorBranch	$customPurple
	set charArrow   $charArrowPass

	set branch (git branch ^/dev/null | grep \* | sed 's/* //')

	if test $error -eq 130
		set error
		set colorArrow $customRed
		set charArrow $charArrowTerm
	else if test $error -ne 0
		set error $error\ ;
		set colorArrow $customRed
		if test $error -ne 130
			set charArrow $charArrowFail
		end
	else if test -n "$branch"
		set error
		set changes (get_git_changes)
		if test -n "$changes"
			set changes (string split \  $changes)
			set colorArrow $customBlue
			if test $changes[1] -ne 0 -a $changes[2] -ne 0
				set charArrow $charGitBoth
			else if test $changes[1] -ne 0
				set charArrow $charGitAhead
			else
				set charArrow $charGitBehind
			end
		end
	else
		set error
	end

	set charArrow "$charArrow "

	sudo -n true 2> /dev/null;
	if test $status -eq 0
		set charUser "#"
	end

	# $colorUser amp $colorAt @ $colorHost mac\  \
	echo -n -s \
		$colorArrow┌\  \
		$colorTime (date "+%H:%M")\  \
		$colorPath (prompt_pwd) \
		\n \
		$colorArrow └$charArrow \
		$colorBranch $branch\  \
		$colorError $error \
		$colorChar $charUser\  \
		$colorNormal;
end

function get_git_changes
	set branch (git branch ^/dev/null | grep \* | sed 's/* //')
	set remote (git config branch.$branch.remote)
	set merge_branch (git config branch.$branch.merge | cut -d / -f 3)
	set rev_list (git rev-list --left-right --count $branch...$remote/$merge_branch)
	set changes (string split \t $rev_list)
	if test $changes[1] -ne 0 -o $changes[2] -ne 0
		echo $changes
	end
end

# WakaTime
set -l project

if echo (pwd) | grep -qEi "^/Users/$USER/GitHub/"
    set project (echo (pwd) | sed "s#^/Users/$USER/GitHub/\\([^/]*\\).*#\\1#")
else if echo (pwd) | grep -qEi "^/Users/$USER/.config/"
    set project (echo (pwd) | sed "s#^/Users/$USER/.config/\\([^/]*\\).*#\\1#")
	set project .config/$project
else
    set project "Terminal"
end

wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&

