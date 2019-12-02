#!/bin/bash

filename="$(dirname "$0")/input"
if [[ $1 ]]; then
    filename=$1
fi
input=$(< "$filename")

IFS=',' read -r -a instructions <<< "$input"

add() {
	echo $(( $1 + $2))
}

multiply() {
	echo $(( $1 * $2 ))
}

start=0
step=4

# As mandated by quiz
instructions[1]=12
instructions[2]=2

while :; do
	opcode=${instructions[$start]}
	left=${instructions[$((start+1))]}
	right=${instructions[$((start+2))]}
	storeAt=${instructions[$((start+3))]}
	do="add"
	if (( opcode == 2 )); then
		do="multiply"
	elif (( opcode == 99 )); then
		break
	fi
	instructions[$storeAt]="$($do "${instructions[$left]}" "${instructions[$right]}")"

	start=$((start+step))
done
echo "${instructions[0]}"
