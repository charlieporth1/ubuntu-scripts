#!/bin/bash
#dig +short myip.opendns.com @resolver1.opendns.com
ARGS="$@"
[[ -z `echo "$ARGS" | grep -Eio '(\-\-|\-)(h|host)(=| )'` ]]
if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(ip|ip-address|cip|current-ip)'` ]]; then
	RANMDOM_NUMBER=$((( RANDOM % 5 )))
	IP_THRU_DNS=`dig +short myip.opendns.com @resolver1.opendns.com`
	IP_THRU_CURL=`curl -s -w '\n' 'https://api.ipify.org/'`
	if [[ $RANMDOM_NUMBER -lt 3 ]]; then
		if [[ $IP_THRU_CURL =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
			echo "$IP_THRU_CURL"
		else
			echo "$IP_THRU_DNS"
		fi
	else
		echo "$IP_THRU_DNS"
	fi
	#curl ifconfig.co/json
else
	HOST="${1:-dns.ctptech.dev}"
#	export EXT_IP=`host $HOST | awk '{print $4}'`
	export EXT_IP=`dig +short $HOST`
	printf "$EXT_IP\n"
fi
