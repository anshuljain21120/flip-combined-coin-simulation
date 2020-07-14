#! /bin/bash -x

echo "Welcome to Flip Combined Coin Simulation!";
echo "This problem displays winning percentage of Head or Tail combination in a single, Doublet or Triplet";

function flip_a_coin()
{
	if [ $((RANDOM%2)) -eq 1 ]
	then
		echo "Head";
	else
		echo "Tail";
	fi
}

echo "$( flip_a_coin )";
