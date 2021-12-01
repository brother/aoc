#!/bin/bash

testmode=false
file=$1
if [[ $1 == "test" ]]; then
       file="a.test.input"
       testmode="true"
fi

mapfile -t input < "$file"

count=0
for depth in "${input[@]}"; do
	if [[ -n $prev ]] && (( depth > prev )); then
		((count++))
	fi
	prev=$depth
done
echo "There are $count measurements that are larger than the previous measurement."
