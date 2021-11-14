#!/bin/bash
#dig +short myip.opendns.com @resolver1.opendns.com
# dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com
# dig -t aaaa +short myip.opendns.com @resolver1.opendns.com
# curl -6 https://ifconfig.co
# curl -6 https://ipv6.icanhazip.com  
# curl https://api64.ipify.org
# curl -6 http://ipinfo.io/ip
# telnet -6 ipv6.telnetmyip.com 
#   ssh -6 sshmyip.com
# ip -6 addr show scope global 
ARGS="$@"
[[ -z `echo "$ARGS" | grep -Eio '(\-\-|\-)(h|host)(=| )'` ]]
if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(ip|ip-address|cip|current-ip)'` ]]; then
	RANMDOM_NUMBER=$((( RANDOM % 5 )))
	IP_THRU_DNS=`dig +short myip.opendns.com @resolver1.opendns.com`
#	IP_THRU_DNS_AAAA_IPV6=`dig -t AAAA +short myip.opendns.com @resolver1.opendns.com`
	if [[ $RANMDOM_NUMBER -lt 3 ]]; then
		IP_THRU_CURL=`curl -s -w '\n' 'https://api.ipify.org/'`
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
