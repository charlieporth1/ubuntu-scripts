#!/bin/bash
byte="Bytes"
kilo="KB"
mega="MB"
giga="GB"
function bytesToUnites() {
if (( "$1" < 1000 )) 
then
    echo $1" "$byte
elif (( $1 < 1000000 ))
then
    let $1/=1000
    echo $1" "$kilo
fi
}
function bytes(   
    gb=$(((mb=(kb=1024*(b=1))*kb)*kb))                 #define units 
    set -- 8934752983457                               #your $1 - just a random test
    for u in '' k m g                                  #this part is neat
    do  [ $((c=$1/${u}b)) -ge 1 ] || break             #math eval varnames
        [ "$u" != g ] && c=$(($c%$kb))                 #if not yet g only save %
        set -- $(($1-$c)) "$c${u}b${2:+.$2}"           #decrement $1 - build $2
    done ; shift                                       #done - toss $1
    IFS=. ; printf %s\\n $*                            #split $2 andd print
)

bytesToUnites 28888

