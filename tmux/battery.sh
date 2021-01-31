#!/bin/bash
echo $(acpi | sed 's/.\+ \([0-9]\+\)%.*/\1/g')

