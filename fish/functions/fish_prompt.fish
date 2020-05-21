function fish_prompt
	set error $status
	set userColor 4F4
	set userChar "\$"
	if test $USER = root
		set userColor F44
		set userChar "#"
	end
	sudo -n true 2> /dev/null;
	if test $status -eq 0
		set userColor F44
		set userChar "#"
	end

	# set colorUser		(set_color FA2)
	# set colorAt			(set_color FF4)
	# set colorHost		(set_color 9C5)
	# set colorColon		(set_color 999)
	# set colorPath		(set_color 3AF)
	# set colorChar		(set_color 44F)
	# set colorError		(set_color F44)
	# set colorBracket	(set_color D22)
	# set colorChar		(set_color $userColor)
	set colorUser		(set_color FA2)
	set colorAt			(set_color 9C5)
	set colorHost		(set_color 3AF)
	set colorColon		(set_color 999)
	set colorPath		(set_color 35C)
	# set colorPath		(set_color A2B)
	set colorChar		(set_color 44F)
	set colorError		(set_color F44)
	set colorBracket	(set_color D22)
	set colorChar		(set_color $userColor)
	set colorNormal		(set_color normal)

	if test $error -eq 0
		set error ""
	else
		set error " "$error
	end

	echo -n -s \
		# $colorBracket "[" \
		$colorUser $USER \
		$colorAt @ \
		$colorHost (hostname -s) \
		$colorColon ":" \
		# $colorColon " " \
		$colorPath (prompt_pwd) \
		$colorError $error \
		# $colorBracket "]" \
		$colorChar " $userChar " \
		$colorNormal;
end

#function fish_prompt
#	set error $status
#	set userColor 4F4
#	set userChar "\$"
#	if test $USER = root
#		set userColor F44
#		set userChar "#"
#	end
#	set colorUser (set_color $userColor)
#	set colorColon (set_color 999)
#	set colorPath (set_color 44F)
#	set colorChar (set_color 44F)
#	set colorError (set_color F44)
#	#####
#	# sudo -n true 2> /dev/null;
#	# if test $status -eq 0
#	# 	set colorChar (set_color F44)
#	# 	set userChar "#"
#	# end
#	#####
#	if test $error -eq 0
#		set error ""
#	else
#		set error " "$error
#	end

#	echo -n -s $colorUser $USER @$hostname $colorColon ":" $colorPath (prompt_pwd) $colorError $error $colorChar " $userChar ";
#end

