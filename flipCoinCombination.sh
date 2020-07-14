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
function flip_combined_coin()
{
	local limit=$1;
	local result="";
	while [ $limit -gt 0 ]
	do
		result="$result$( flip_a_coin )";
		((limit--));
	done
	echo "$result";
}
function flip_coin_till()
{
	local -n _dict=$1;
	local combination=$2;
	local limit=${3:-10};
	for (( counter=1; counter<=limit; counter++ ))
	do
		toss_result="$( flip_combined_coin $2 )";
		_dict["$toss_result"]=$(( ${_dict["$toss_result"]} + 1 ));
	done
	for key in ${!_dict[@]};
	do
		_dict[$key]=$(( (_dict[$key]*100)/$limit ));
	done
}
declare -A singlet_toss_distribution;
singlet_toss_distribution=(["H"]=0 ["T"]=0 );
declare -A doublet_toss_distribution;
doublet_toss_distribution=(["HH"]=0 ["HT"]=0 ["TH"]=0 ["TT"]=0 );
declare -A triplet_toss_distribution;
triplet_toss_distribution=(["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["THH"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 );
flip_coin_till triplet_toss_distribution 3;
