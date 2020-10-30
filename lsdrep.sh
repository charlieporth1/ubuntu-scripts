#!/usr/bin/parallel  --shebang-wrap --pipe /bin/bash
#!/bin/bash
#echo
#term=$(tput cols)
#echo $term 
#export numb=number
export y="printf y"
read -p "do you want this to go on forver y/n" yn
case $yn in
[Yy]* )
while(true) do
#if(read q) then
#exit
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
echo 
#fi
done;;
[Nn]* )
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
echo ;;
* ) echo "please enter y or n"
esac 
done
