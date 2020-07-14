#! /bin/bash -x

echo "Welcome to Flip Combined Coin Simulation!";
echo "This problem displays winning percentage of Head or Tail combination in a single, Doublet or Triplet";

function flip_a_coin()
{
	if [ $((RANDOM%2)) -eq 1 ]
	then
		echo "H";
	else
		echo "T";
	fi
}
function flip_coin_till()
{
	local -n _dict=$1;
	local limit=${2:-10};
	for (( counter=1; counter<=limit; counter++ ))
	do
		toss_result="$( flip_a_coin )";
		_dict["$toss_result"]=$(( ${_dict["$toss_result"]} + 1 ));
	done
	for key in ${!_dict[@]};
	do
		_dict[$key]=$(( (_dict[$key]*100)/$limit ));
	done
}
declare -A singlet_toss_distribution;
singlet_toss_distribution=(["H"]=0 ["T"]=0 );
flip_coin_till singlet_toss_distribution;
echo "${singlet_toss_distribution[@]}";
