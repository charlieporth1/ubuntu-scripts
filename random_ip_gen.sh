#!/bin/bash
export dot='.'
export RANGE=255
number=$RANDOM
number1=$RANDOM
number2=$RANDOM
number3=$RANDOM
let "number %= $RANGE"
let "number1 %= $RANGE"
let "number2 %= $RANGE"
let "number3 %= $RANGE"

echo $number$dot$number1$dot$number2$dot$number3
