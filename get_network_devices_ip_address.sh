#!/bin/bash
ARGS="$@"

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(g|grepify|grep)'` ]] && isGrepify=true || isGrepify=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(c|csvify|csv)'` ]] && isCSV=true || isCSV=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(l|lo|local|loop|localhost|loopback)'` ]] && noLo="|lo:?[0-9]?" || noLo=""
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(w|wl|wlan|wifi|wi)'` ]] && noWLAN="|wlan[0-9]" || noWLAN=""
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(a|all)'` ]] && ALL="true" || ALL="false"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)((o|only)?)(s|1|f|single|one|first)((i|interface|iface)?)'` ]] && OnlyOneSingle="true" || OnlyOneSingle="false"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(d|default)(((-)(i|interface|iface))?)'` ]] && defaultInterface="true" || defaultInterface="false"

IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"
ODD_ETH_REGEX="(n(x|s|n|o|p|e)([[:alnum:]]*))"

NET_DEVICE_REGEX="(e($ODD_ETH_REGEX|th[0-9])$noWLAN$noLo)"
NET_DEVICE_REGEX_IFCONFIG="$NET_DEVICE_REGEX\:"

IP_ADDRESS=$(sudo ifconfig | grep -E "$NET_DEVICE_REGEX_IFCONFIG" -A 1 | grep -oE "inet $IP_REGEX" | grep -oE "$IP_REGEX")
if [[ "$ALL" == 'true' ]]; then
	sudo ip address | grepip -o
else
	if [[ $isGrepify == true ]]; then
		bash $PROG/grepify.sh $IP_ADDRESS
	elif [[ $defaultInterface == true ]] || [[ $OnlyOneSingle == true ]]; then
	#	export default_iface=`route | grep '^default' | grep -o '[^ ]*$'  | sort -u`
		export default_iface=`sudo ip route | grep '^default' | grep -oiE "$NET_DEVICE_REGEX" | awk '{ print $1}' | sed -n '1p'`
		export default_iface_address=`sudo ifconfig $default_iface | awk '{print $2}' | grepip -4`
		if [[ $OnlyOneSingle == true ]]; then
			printf '%s\n' "$default_iface_address" | sed -n '1p'
		else
			printf '%s\n' "$default_iface_address"
		fi
	elif [[ $isCSV == true ]]; then
		bash $PROG/csvify.sh $IP_ADDRESS
	else
		printf '%s\n' "$IP_ADDRESS"
	fi

fi

