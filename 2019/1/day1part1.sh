#!/bin/bash

# 12, 2
# 14, 2
# 1969, 654
# 100756, 33583

filename="$(dirname "$0")/a_input"
if [[ $1 ]]; then
    filename=$1
fi

total=0
while read -r line; do
	value=${line%,*}
	need=$(($(($value/3))-2))
	echo $need
	total=$((need+total))
done < "$filename"
echo "-----"
echo $total
