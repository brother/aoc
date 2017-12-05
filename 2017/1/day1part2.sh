#!/bin/bash

testdata=(1212 1221 123425 123123 12131415)
testexpected=(6 0 4 12 4)

if [[ $1 ]]; then
	data=$1
fi

checkSolution () {
	local string=$1
	local inputdata
	# Split string per char to array.
	mapfile -t inputdata < <(for ((i=0;i<${#string};i++)); do echo "${string:$i:1}"; done)

	result=0
	nbrofelements=${#inputdata[@]}
	lookahead=$((nbrofelements/2))
	for ((i=0;i<nbrofelements;i++)); do
		this=${inputdata[$i]}
		nextindex=$((i+lookahead))
		next=${inputdata[$nextindex]}
		# Reconsider when outside of the length
		if (( nextindex >= nbrofelements )); then
			left=$((nextindex-nbrofelements))
			next=${inputdata[$((0+left))]}
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
