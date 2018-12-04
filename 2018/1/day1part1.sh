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
while read -r change; do
	echo -n "Current frequency $current, change of $change; "
	current=$((current + change))
	echo "resulting frequency $current"
done < "$filename"
