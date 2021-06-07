#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
echo "Running DOQ TEST"
[[ "$1" == "-a" ]] && isAuto="-o"


QUERY=www.google.com
HOST=dns.ctptech.dev
TIMEOUT=60
WAIT_TIME=2.5s
TRIES=8
# qdig -server dns.ctptech.dev:784 -dnssec -recursion dns.ctptech.dev A

DNS_IP=`$PROG/grepify.sh $(bash $PROG/get_ext_ip.sh)`
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"

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

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi
#  q --server=dns.ctptech.dev --qname=www.google.com @quic://dns.ctptech.dev:784
#  q --server=dns.ctptech.dev --qname=www.google.com @quic://dns.ctptech.dev:784 --timeout=60 --dnsses
exit 0 #TMP GOING TO PARTY WITH KIMBERLY REMOVE LATER 
#doq=$(timeout $TIMEOUT qdig -server $HOST:784 -dnssec -recursion $QUERY A)
doq=$( q --server=$HOST --qname=$QUERY @quic://ctp-vpn.local:784 --timeout=$TIMEOUT --dnssec )
dns_local=`dig $QUERY @ctp-vpn.local  +tries=$TRIES +dnssec`
dns_local_test=`printf '%s\n' "$dns_local" | grep -v "$EXCLUDE_IP" | grepip --ipv4 -o | xargs`


if [[ -z $isAuto ]]; then
   echo -e "LOCAL\n$(bash $PROG/lines.sh '*')\n"
   printf '%s\n' "$doq"
else
#	qdig -server $HOST:784 -dnssec -recursion $HOST A
	isSystemInactive=`systemctl status ctp-dns | grep -oE '(de|)activating'`
	doq_test=$(echo "$doq" | grep -oE "$IP_REGEX" | xargs)
	log_d "doq_test :$doq_test:"
	if  [[ -z "$doq_test" ]] && [[ -z "$isSystemInactive" ]]; then
		echo "DOQ FAILED doq_test :$doq_test:"
		if [[ -z "$dns_local_test" ]]; then
                        echo "DNS FAILED NOT DOT"
                        exit 1
                fi
		systemctl daemon-reload
		systemctl restart ctp-dns
                sleep $WAIT_TIME
	else
                echo "DOQ SUCCESS"
	fi
fi
