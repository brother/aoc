#!/bin/bash

# 12, 2
# 14, 2
# 1969, 654
# 100756, 33583

filename="$(dirname "$0")/a_input"
if [[ $1 ]]; then
    filename=$1
fi

checkandcount() {
	value=$1
	need=$(($((value/3))-2))
	echo $need
}

total=0
while read -r line; do
	value=${line%,*}
	while :; do
		new=$(checkandcount "$value")
		(( new < 1 )) && break
		total=$((new+total))
		value=$new
	done
done < "$filename"
echo $total
