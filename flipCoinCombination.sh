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
function get_max_value()
{
	local -n _dict=$1;
	local _max_value=-999;

	for key in ${!_dict[@]}
	do
		if [ $_max_value -lt $((_dict[$key])) ]
		then
			_max_value=$((_dict[$key]));
		fi
	done
	echo "$_max_value";
}
function max()
{
	if [ "$1" -gt "$2" ]
	then
		echo "$1";
	else
		echo "$2";
	fi
}
declare -A singlet_toss_distribution;
singlet_toss_distribution=(["H"]=0 ["T"]=0 );
flip_coin_till singlet_toss_distribution 1;

declare -A doublet_toss_distribution;
doublet_toss_distribution=(["HH"]=0 ["HT"]=0 ["TH"]=0 ["TT"]=0 );
flip_coin_till doublet_toss_distribution 2;

declare -A triplet_toss_distribution;
triplet_toss_distribution=(["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["THH"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 );
flip_coin_till triplet_toss_distribution 3;

maximum_of_all=-999;
maximum_of_all=$( max "$(get_max_value singlet_toss_distribution)" "$maximum_of_all" );
maximum_of_all=$( max "$(get_max_value doublet_toss_distribution)" "$maximum_of_all" );
maximum_of_all=$( max "$(get_max_value triplet_toss_distribution)" "$maximum_of_all" );
echo "Winner of all three combination is value: $maximum_of_all";