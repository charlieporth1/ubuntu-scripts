#!/bin/bash
ARGS="$@"

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(g|grepify|grep)'` ]] && isGrepify=true || isGrepify=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(c|csvify|csv)'` ]] && isCSV=true || isCSV=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(l|lo|local|loop|localhost|loopback)'` ]] && noLo="|lo:?[0-9]?" || noLo=""
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(w|wl|wlan|wifi|wi)'` ]] && noWLAN="|wlan[0-9]" || noWLAN=""

IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"

NET_DEVICE_REGEX="(e(n(x|s|n|o|p|e)([[:alnum:]]*))|th[0-9]$noWLAN$noLo)\:"

IP_ADDRESS=$(sudo ifconfig | grep -E "$NET_DEVICE_REGEX" -A 1 | grep -oE "inet $IP_REGEX" | grep -oE "$IP_REGEX")

if [[ $isGrepify == true ]]; then
	bash $PROG/grepify.sh $IP_ADDRESS
elif [[ $isCSV == true ]]; then
	bash $PROG/csvify.sh $IP_ADDRESS
else
	printf '%s\n' "$IP_ADDRESS"
fi
