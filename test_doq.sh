#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
echo "Running DOQ TEST"
[[ "$1" == "-a" ]] && isAuto="-o"

IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"

QUERY=www.google.com
HOST=dns.ctptech.dev
TIMEOUT=4
WAIT_TIME=2.5s
TRIES=3
# qdig -server dns.ctptech.dev:784 -dnssec -recursion dns.ctptech.dev A

DNS_IP=`$PROG/grepify.sh $(bash $PROG/get_ext_ip.sh)`
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"

if ! command -v qdig &> /dev/null
then
    echo "COMMAND qdig could not be found"
    exit
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

exit 0 #TMP GOING TO PARTY WITH KIMBERLY REMOVE LATER 
doq=$(timeout $TIMEOUT qdig -server $HOST:784 -dnssec -recursion $QUERY A)

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
