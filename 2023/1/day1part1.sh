#!/bin/bash

file=a.test.input
testmode="true"
if [[ -n $1 ]]; then
	file=$1
	testmode="false"
fi

if ! [[ -f $file ]]; then
	echo "File '$file' not founde."
	exit 1
fi
mapfile -t values < "$file"

sum=0
for line in "${values[@]}"; do
	first=x
	last=x
	for ((i=0;i<${#line};i++)); do
		position=${line:$i:1}
		if [[ $position =~ [0-9] ]]; then
			first=$position
			break
		fi
	done

	for ((j=${#line};j>0;j--)); do
		position=${line:$((j-1)):1}
		if [[ $position =~ [0-9] ]]; then
			last=$position
			break
		fi
	done

	if [[ $testmode == "true" ]]; then
		echo "$line"
		echo "$first$last"
	fi
	integer="$first$last"
	sum=$(( sum + integer ))
done

echo "The value totals to: $sum"
if [[ $testmode == "true" ]]; then
	solution=$(< a.test.solution)
	if (( sum != solution )); then
		echo "...but that's not correct. It's supposed to be $solution."
	fi
fi
