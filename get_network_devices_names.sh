#!/bin/bash
ARGS="$@"
source $PROG/all-scripts-exports.sh
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(g|grepify|grep)'` ]] && isGrepify=true || isGrepify=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(c|csvify|csv)'` ]] && isCSV=true || isCSV=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(l|lo|local|loop|localhost|loopback)'` ]] && noLo="|lo:?[0-9]?" || noLo=""
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(w|wl|wlan|wifi|wi)'` ]] && noWLAN="|wlan[0-9]" || noWLAN=""
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(a|all)'` ]] && ALL="true" || ALL="false"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)((o|only)?)(s|1|f|single|one|first)((i|interface|iface)?)'` ]] && OnlyOneSingle="true" || OnlyOneSingle="false"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(d|default)(((-)(i|interface|iface))?)'` ]] && defaultInterface="true" || defaultInterface="false"

NET_DEVICE_REGEX="(e($ODD_ETH_REGEX|th[0-9])$noWLAN$noLo)"
NET_DEVICE_REGEX_IFCONFIG="$NET_DEVICE_REGEX\:"

IP_ADDRESS=$(sudo ifconfig | grep -E "$NET_DEVICE_REGEX_IFCONFIG" | awk -F: '{print $1}' | sort -u)

if [[ "$ALL" == 'true' ]]; then
	printf '%s\n' "$IP_ADDRESS"
else

	if [[ $isGrepify == true ]]; then
                bash $PROG/grepify.sh $IP_ADDRESS
        elif [[ $defaultInterface == true ]] || [[ $OnlyOneSingle == true ]]; then
                if [[ $OnlyOneSingle == true ]]; then
                        printf '%s\n' "$default_iface" | sed -n '1p'
                else
                        printf '%s\n' "$default_iface" | sort -u
                fi
        elif [[ $isCSV == true ]]; then
                bash $PROG/csvify.sh $IP_ADDRESS
        else
                printf '%s\n' "$IP_ADDRESS"
        fi

fi
