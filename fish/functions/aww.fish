#!/usr/bin/fish

function aww
	set PAGE_CODE (wiki-search --all | fzf --cycle --nth ..-1 --with-nth ..-2 --header "Select an Arch-Wiki Page" --preview "wiki-search (echo {} | cut -d ' ' -f 2-) 2> /dev/null | bat --style=numbers --color=always");
	set ERROR $status
	if test $ERROR -ne 0
		return $ERROR
	else
		wiki-search (echo $PAGE_CODE | awk '{print $NF}');
	end
end

