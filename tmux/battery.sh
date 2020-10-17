#!/bin/bash
# cat /sys/class/power_supply/BAT0/capacity
echo $(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

