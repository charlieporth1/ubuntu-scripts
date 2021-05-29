#!/usr/bin/env bash
#!/bin/bash
#echo
for  ((number=1;number < $(tput cols);number++)) #in {1..$(tput lines)}
do

echo -ne "#"


done|lolcat -a -d 500
echo 
exit
