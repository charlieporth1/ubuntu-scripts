#!/bin/bash
bMonth="June"
cMonth="December"
currentDate=$(date | awk '{print $2}')
char="${1:-#}"
for ((number=1;number <= $(tput cols);number++)) #in {1..$(tput lines)}
do

echo -ne "$char"

done | lolcat
echo
