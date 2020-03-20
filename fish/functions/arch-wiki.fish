#!/usr/bin/fish

function arch-wiki
	set PAGE_CODE (wiki-search $argv | fzf --with-nth 1..-2);
	set ERROR $status
	if test $ERROR -ne 0
		return $ERROR
	else
		wiki-search (echo $PAGE_CODE | awk '{print $NF}');
	end
end

