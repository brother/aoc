#!/bin/bash

testdata=(1122 1111 1234 91212129)
testexpected=(3 4 0 9)

if [[ $1 ]]; then
	data=$1
fi

checkSolution () {
	local string=$1
	local inputdata
	# Split string per char to array.
	mapfile -t inputdata < <(for ((i=0;i<${#string};i++)); do echo "${string:$i:1}"; done)
	result=0
	for ((i=0;i<${#inputdata[@]};i++)); do
		this=${inputdata[$i]}
		next=${inputdata[$((i+1))]}
		# Wrap around for the last element.
		if (( $((i+1)) == ${#inputdata[@]} )); then
			next=${inputdata[0]}
		fi
		if [[ $this == "$next" ]]; then
			result=$((result+this))
		fi
	done
	echo "$result"
}

assertEqual () {
	local expected=$1
	local actual=$2
	local msg=$3
	if [[ $actual != "$expected" ]]; then
		echo "Unable to assert that $actual is equal to $expected. ${msg:-}"
		exit 1
	fi
}

echo -n "Execute tests..."
for ((i=0;i<${#testdata[@]};i++)); do
	assertEqual "${testexpected[$i]}" "$(checkSolution ${testdata[$i]})"
done
echo "OK"
if [[ $data ]]; then
	echo "Finding solution..."
	checkSolution "$data"
fi
