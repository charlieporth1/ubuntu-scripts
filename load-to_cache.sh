#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
FILE=${1:-$HOLE/custom_local_cache_domains.txt}
TIMEOUT=2
TRIES=1
mapfile -t DOMAINS < $FILE
interval=8
for c in `seq 0 $interval ${#DOMAINS[@]}`
do
        (
                for i in {0..6}
                do
                (
                        e=$(($c+$interval))
                        dig @pihole$i.local +timeout=$TIMEOUT +tries=$TRIES +dnssec ${DOMAINS[@]:$c:$e}
                )&>/dev/null
                done
      	)&
done
