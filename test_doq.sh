#!/bin/bash
source $PROG/test_dns_args.sh
CONCURRENT
dns_logger "Running DoQ TEST"

# qdig -server dns.ctptech.dev:784 -dnssec -recursion dns.ctptech.dev A

if ! command -v qdig &> /dev/null
then
    echo "COMMAND qdig could not be found"
    exit
fi

if ! command -v q &> /dev/null
then
	echo "COMMAND q could not be found"
#	https://github.com/natesales/q/releases/download/v0.4.1/q_0.4.1_linux_amd64.deb
 	LATEST_VERSION=`curl --silent "https://api.github.com/repos/natesales/q/tags" | jq -r '.[0].name'`
	echo $LATEST_VERSION
	RELEASE=`echo $LATEST_VERSION | awk -Fv '{print $2}'`
	REST_FILE=_linux_amd64.deb
	VP=q_$RELEASE$REST_FILE
#	wget https://github.com/natesales/q/releases/latest/download/$LATEST_VERSION/$VP -O ~/$VP
	wget https://github.com/natesales/q/releases/latest/download/$VP -O ~/$VP
	sudo dpkg -i ~/$VP
	exit
fi
#  q --server=dns.ctptech.dev --qname=www.google.com @quic://dns.ctptech.dev:784
#  q --server=dns.ctptech.dev --qname=www.google.com @quic://dns.ctptech.dev:784 --timeout=60 --dnsses
exit 0 #TMP GOING TO PARTY WITH KIMBERLY REMOVE LATER
#doq=$(timeout $TIMEOUT qdig -server $HOST:784 -dnssec -recursion $QUERY A)
doq=$( q --server=$HOST --qname=$QUERY @quic://ctp-vpn.local:784 --timeout=$TIMEOUT --dnssec )

if [[ -z $isAuto ]]; then
   echo -e "LOCAL\n$(bash $PROG/lines.sh '*')\n"
   printf '%s\n' "$doq"
else
#	qdig -server $HOST:784 -dnssec -recursion $HOST A
	doq_test=$(echo "$doq" | grep -oE "$IP_REGEX" | xargs)
	log_d "doq_test :$doq_test:"
	if  [[ -z "$doq_test" ]] && [[ $(systemctl-inbetween-status ctp-dns.service) == false ]]; then
		if_plain_dns_fail
		dns_logger "DOQ FAILED doq_test :$doq_test:"
		[[ -f $PROG/dns-route.sh ]] && bash $PROG/dns-route.sh
		systemctl daemon-reload
		systemctl restart ctp-dns
                #sleep $WAIT_TIME
	else
                dns_logger "DOQ SUCCESS"
	fi
fi
