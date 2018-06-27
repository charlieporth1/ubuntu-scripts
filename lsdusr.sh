#!/bin/bash
#echo
#for ((number=1;number<$(tput cols);number++))  #in {1..$(tput lines)}
for ((n=1;n<$(tput cols);n++))  #in {1..$(tput lines)}
#for  number in {1...$(tput cols)}
do
#echo -ne $number
echo -ne  "$"
done|lolcat -a -d 500 
echo
exit
