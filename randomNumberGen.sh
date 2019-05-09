#!/bin/bash
debugg=false
export whatRandom=/dev/frandom #${randoms[$num]}
function log() {
        if [[ $debugg == true ]]; then
                if [[ -z ${FUNCNAME[1]} ]]; then
                        echo "Log message: $1" >&2
                else
                        echo "${FUNCNAME[0]} message: Function: ${FUNCNAME[1]}: $1" >&2
                fi
        fi
}

function randomNum() {
        log 'exec randomNum '
        local RANGE=$1  
        log "RANGE: $RANGE " 
        local acceptZero=$2
        local number=$RANDOM
        if [[  $acceptZero ]]; then
                log "accept ZERO $acceptZero "
                export number=$(( ((RANDOM<<1)|RANDOM) % $RANGE ))
        elif [[ $acceptZero =~ [0-9]^ ]]; then
                log "Number regex; Min number $acceptZero "
                export number=$((((RANDOM<<$acceptZero)|RANDOM) % $RANGE ))
        else
                log "accept ZERO $acceptZero "
                let "number%=$RANGE"
        fi
        log "RANDOM NUMBER: $number "
        echo $number
        return
}
function randomWait() {
        log 'exec randomWait '
        local range=255
        cutLength
        log "starting hex "
        local hex=`randomHex $range $cutCharMin $cutCharMax`
        log "hex $hex"
        log "hex done"
        local hexRev=`echo "$hex" | rev`
        log "hexRev $hexRev"
        local hexSub=`echo ${numRev:1-0}`
        log "hexSub $hexSub"
        local hexFirstDigit=`echo ${num:0-1} | rev`
        log "hexFirstDigit $hexFirstDigit"
        if [[ $numSub = "F" ]]; then 
                local singleHex=`randomSingleHex`
                log "first char F so choosing a random hex"
                log "hexFirstDigit $singlecHex"
                waitTime=`echo "$(randomSingleHex)$hexSub"`
        else 
                waitTime="$hex"
        fi
        local num=`echo "ibase=16; $waitTime" | bc`
        local msS=1000
        ms=`bc -l <<< "scale=4;$num/1000"`
#       ms=$(($num/ 1000 ))
#       let "ms=/\$num"
#       waitTime=`cat /dev/urandom | hexdump | sed -n '$num$p' | bc`
        log "sleeping ms: $ms; dec: $num; hex: $hex; ms: $ms "
#        sleep $ms
	echo $ms
        log "exec done randomWait "
        return
}
function randomHex() {
        log 'exec randomHex '
        local range=$1
        local cutMin=$2
        local cutMax=$3 
        local minusCut=6
        local num=`randomNum $range true`
#       let "minusCut=$cutMin-$cutMax"
        minusCut=$(($cutMax-$cutMin))
        local randomHex=`randomSingleHex`
        local p='p'
        local hex=`head -c $(($num*16+5)) $whatRandom | hexdump | sed -n "$num$p" | cut -c $minusCut-$cutMax | tr " " "$randomHex"`
        local HEX=${hex^^}
        log "exec done with randomHex "
        echo $HEX
        return
}   
function cutLength() {
        log 'exec cutLength '
        local range=109
        local maxLength=`randomNum 6 true`
        log "maxLength: $maxLength "
        #sleep 1s
        local charStart=$((9+$maxLength))
        #charMin=`randomNum 8`
        local charMax=`randomNum 32 $charStart`
        log "charMax: $charMax "
        local charSelection=$(( ((RANDOM<<$charStart)|RANDOM) % $charMax ))
        log "selected Char \#: $charSelection "
        log "selected Char \# min: $maxLength "
#       selectHex=`randomNum $charSelection`
#       hexSelection=$(( ((RANDOM<<)|RANDOM) % 32 ))
        local p='p'
#       let "charStart=$maxLength-$charSelection"
        local charStart=$(($charSelection-$maxLength))
#       hex=`head -c $(($range+5)) /dev/urandom | hexdump | sed -n '$number$p' | cut -c $charStart-$charSelection | sed 's/\ //g'`
#       export cutCharMin=$charMin
        export cutCharMin=$maxLength
        export cutCharMax=$charSelection
        export charSelection=$charSelection
        export maxLength=$maxLength
        log "done cutLength "
        return
} 
function randomSingleHex() {
        log "exec randomSingleHex "
        local range=18
        local minus=6 # this make sure there are chars 
        local num=`randomNum $range true`
        local minChar=$((10+$minus))
        local charStart=2
        #local charMin=`randomNum 8`
        local charMax=`randomNum 32 $minChar`
        log "charMax $charMax"
        local charSelection=$(( ((RANDOM<<$minChar)|RANDOM) % $charMax ))
        log "charSelection $charSelection"
        local p='p'
        #if [[ $charMin < $charMax ]]; then
        let "charStart=$minus-$charSelection"
        local charStart=$(($charSelection-$minus))
#       local charStart=$(($minus-$charSelection))
        log "charStart $charStart"
        #fi
        local hexa=`head -c $(($num*16+6)) /dev/urandom | hexdump | sed -n "$num$p" | cut -c $charStart-$charSelection | sed "s/ //g"`
        #if [[  $hex =~ [[:space:]]* ]]; then
        #       log "found spaces"
        #       local hexa=`echo $hex | sed 's/ //g'`
        #else 
        #       local hexa=${hex} 
        #fi 
        log "hexa $hexa"
#       log "hex $hex"
        local hexadecimal=`echo ${hexa^^} | cut -c 1-1`
        log "hexadecimal $hexadecimal"
        echo $hexadecimal
        log "done randomSingleHex "
        return
}      
export -f randomSingleHex 
export -f cutLength
export -f randomNum
export -f randomWait
export -f randomHex
	echo "" > ./data.csv
for ((i=0; i < 100; i++ ))
do
	num=`randomWait`
	echo $num
	echo "$num," >> ./data.csv
	sleep 1s
done
