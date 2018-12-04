#!/bin/bash

#  3 testdata_1a.txt
#  0 testdata_1b.txt
# -6 testdata_1c.txt
#  3 testdata_1d.txt

filename="$(dirname "$0")/input"
if [[ $1 ]]; then
	filename=$1
fi

current=0
declare -A seen
while :; do
	while read -r change; do
		echo -n "Current frequency $current, change of $change; "
		current=$((current + change))
		echo -n "resulting frequency $current"
		index=$current
		# Array field index can not have dasehs in it... substring and replace.
		if (( current < 0 )); then
			index="minus${current:1}"
		fi

		if [[ ${seen[$index]} != 1 ]]; then
			echo "."
			seen[$index]=1
		else
			echo ", which has already been seen."
			echo
			echo "Result $current"
			break 2
		fi
	done < "$filename"
	# Redo loop until collission is found. testdata_1a.txt and
	# testdata_1c.txt will not work with this code, it has no backward
	# steps.
done
