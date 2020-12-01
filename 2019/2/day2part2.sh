#!/bin/bash

filename="$(dirname "$0")/input"
if [[ $1 ]]; then
    filename=$1
fi
input=$(< "$filename")

IFS=',' read -r -a memory <<< "$input"

add() {
	echo $(( $1 + $2))
}

multiply() {
	echo $(( $1 * $2 ))
}

solve() {
	local start step needle noun verb
	start=0
	step=4
	needle=19690720
	noun=$1
	verb=$2
	memory[1]=$noun
	memory[2]=$verb

	while :; do
		opcode=${memory[$start]}
		#echo "n:$noun v:$verb"

		do="add"
		if (( opcode == 2 )); then
			do="multiply"
		elif (( opcode == 99 )); then
			echo "n:$noun v:$verb end program."
			break
		fi
		#echo -n "$do ${memory[$noun]} ${memory[$verb]}"
		haystack=$($do "${memory[$noun]}" "${memory[$verb]}")
		#echo "$haystack"
		if (( needle == haystack )); then
			memory[0]=$needle
			memory[1]=$noun
			memory[2]=$verb
			break
		fi
		#memory[$storeAt]=$haystack

		start=$((start+step))
	done
}

for ((noun=0;noun<100;noun++)); do
	for ((verb=0;verb<100;verb++)); do
		solve "$noun" "$verb"
	done
done

echo "${memory[0]} ${memory[1]} ${memory[2]} -> $((100 * memory[1] + memory[2] ))"
