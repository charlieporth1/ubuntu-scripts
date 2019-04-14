#!/bin/bash
RANGEMIN=1111111111
RANGEMAX=9999999999
number=$RANDOM
let "number %= $RANGEMAX"
PORT=$(( (($RANDOM<<15)|$RANDOM) % $RANGEMAX + $RANGEMIN ))
export areaCode=$1
export buildingCode=$2
#echo $PORT
if [[ "$areaCode" =~ '-ac='*** ]] && ( [[ "$buildingCode" != '-bc='*** ]] || [[ -z $buildingCode ]] ); then 
export code=$(echo $areaCode |  grep -o '[0-9]\{3\}' )
	if [[ ! -z  $fileName ]]; then 
	export fileName=$2
	export start=1111111
	echo $code$start > $fileName 
		for (( i=$start+1; i>=9999999; i++ ))
		do 
			echo $code$i
			echo $code$i >> $fileName
		done
	else 
	export start=1111111
	echo $code$start > phonelist.txt 
		for (( i=$start+1; i>=9999999; i++ ))
		do 
			echo $code$i
			echo $code$i >> phonelist.txt
		done
	fi
elif [[ "$areaCode" =~ '-ac'*** ]] && [[ "$buildingCode" =~ '-bc='*** ]]; then 
export code=$(echo $areaCode |  grep -o '[0-9]\{3\}' )
export bc=$(echo $buildingCode | grep -o '[0-9]\{3\}')
	if [[ ! -z  $fileName ]]; then 
	export fileName=$3
	export start=1111
	echo $code$bc$start > $fileName 
		for (( i=$start+1; i>=9999; i++ ))
		do 
			echo $code$bc$i
			echo $code$bc$i >> $fileName
		done
	else 
	export start=1111111
	echo $code$bc$start > phonelist.txt 
		for (( i=start+1; i>=9999; i++ ))
		do 
			echo $code$bc$i
			echo $code$bc$i >> phonelist.txt
		done
	fi
elif [[ "$areaCode" = ** ]]; then 
	export fileName=$2
        if [[ ! -z  $fileName ]]; then 
		export start=1111111111
		echo $start > $fileName 
			for (( i=$start+1; i>=999999999; i++ ))
			do 
				echo $code$bc$i
				echo $code$bc$i >> $fileName
			done
	else 
		export start=1111111111
		echo $start >  phonelist.txt 
			for (( i=$start+1; i>=999999999; i++ ))
			do 
				echo $code$bc$i
				echo $code$bc$i >> phonelist.txt
			done
	fi
else 
echo 'Usage: for Phone number Gen'
echo '-ac=*** 	area code'
echo 'last stty is file name'
echo '-bc=*** 	building code '
echo 'building code is the second 3 digits in your phone number'
echo 'building code is only used with area code not alone'
echo 'To start from (111) 111-1111 use ** for the area code'
fi
