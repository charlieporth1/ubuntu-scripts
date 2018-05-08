#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash

#echo
for  ((number=1;number <= $(tput cols);number++)) #in {1..$(tput lines)}
do

 echo -ne "#"

done 
echo
exit
