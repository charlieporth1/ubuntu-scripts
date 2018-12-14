#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash 
#!/bin/bash
export bMonth="June"
export cMonth="December"
export currentDate=$(date | awk '{print $2}')
#echo
for  ((number=1;number <= $(tput cols);number++)) #in {1..$(tput lines)}
do

echo -ne "#"

done | lolcat
echo
exit 0

#if [ echo -ne $inv  $bMonth = echo -ne  $currentDate  $reset ]  || [ echo -ne  $inv  $cMonth =  echo -ne  $currentDate  $reset ]
