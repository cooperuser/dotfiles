#!/usr/local/bin/fish
# if test (cat /sys/class/power_supply/BAT0/status) = Discharging
	if test (./battery.sh) -lt 26
		echo -n -s 196
	else
		echo -n -s 40
	end
# else
# 	echo -n -s 190
# end
