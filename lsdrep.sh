#!/usr/bin/env bash
#!/bin/bash
#echo
#term=$(tput cols)
#echo $term 
#export numb=number
for ((number=1;number <= $(tput cols);number++)) #in {1..$(tput lines)}
do
#$number++
echo -ne "$number"
#numb = number 
#echo $number "number"
#echo $numb "numb"
#echo -ne ""
#|lolcat -a -d 500

#if ($number = $term) then
#sleep 1s
#echo  ""
#fi

done|lolcat -a -d 500
exit 
