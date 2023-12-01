#!/bin/bash

file=b.test.input
solution=$(< b.test.solution)
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

words=(one two three four five six seven eight nine)
inarray() { local q=$1 e; shift; (( $# )) && for e; do [[ $q = "$e" ]] && return; done; }
# 	inarray "$needle" "${words[@]}"

sum=0
for line in "${values[@]}"; do
	first=x
	last=x
	for ((i=0;i<${#line};i++)); do
		position=${line:$i:1}
		echo "$position"
		if [[ $position =~ [0-9] ]]; then
			if [[ $first == x ]]; then
				first=$position
			else
				last=$position
			fi
		else
			if ! [[ ${line:$(( i + 1)):1} =~ [0-9] ]]; then
				echo "$line"
			fi
		fi

	done

	if [[ $first == x ]]; then
		# no digits in line
		continue
	fi

	if [[ $last == x ]]; then
		# only one digit found
		last=$first
	fi

	if [[ $testmode == "true" ]]; then
		echo "$line"
		echo "$first$last"
	fi
	integer="$first$last"
	sum=$(( sum + integer ))

	# reset and find next integer
	first=x
	last=x
done

echo "The value totals to: $sum"
if [[ $testmode == "true" ]]; then
	if (( sum != solution )); then
		echo "...but that's not correct. It's supposed to be $solution."
	fi
fi
