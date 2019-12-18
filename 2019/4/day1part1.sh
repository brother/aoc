#!/bin/bash

filename="$(dirname "$0")/a_input"
if [[ $1 ]]; then
    filename=$1
fi
debug="no"
if [[ $2 ]]; then
	if [[ $2 == "debug" ]]; then
		debug=yes
	elif [[ $2 == "debug2" ]]; then
		debug=yes2
	fi
fi
total=0
value=$(< "$filename")
start=${value%-*}
end=${value#*-}

for ((i=start;i<=end;i++)); do
	hasPair=0
	current=$i
	for ((j=$((${#current}-1));j>=0;j--)); do
		thisDigit=${current:j:1}
		if (( j > 0 )) && (( thisDigit < ${current:$((j-1)):1} )); then
			# does not meet criteria of always increasing
			if [[ $debug == "yes" ]]; then
				echo "$current => $thisDigit < ${current:$((j-1)):1}"
			fi
			continue 2
		fi
		if [[ $current != *${thisDigit}${thisDigit}* ]]; then
			# does not meet pair criteria
			if [[ $debug == "yes" ]]; then
				echo "${thisDigit}${thisDigit}"
				echo "$current"
			fi
			continue
		else
			hasPair=1
		fi
	done
	# At this stage the digits are increasing and there might be a pair, just need to double check.
	if (( hasPair != 0 )); then
		if [[ $debug =~ yes(|2) ]]; then
			echo "counting $current"
		fi
		total=$((total+1))
	fi
done
echo "-----"
echo $total
