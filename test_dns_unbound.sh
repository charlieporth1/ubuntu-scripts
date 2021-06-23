#!/bin/bash
if [[ `systemctl-exists unbound.service` == false ]]; then
	exit 1
fi
source $PROG/all-scripts-exports.sh
CONCURRENT
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/charlieporth1_gmail_com/go/bin:$PATH
echo "Running DNS Unbound TEST"
[[ "$1" == "-a" ]] && isAuto="+short"

WAIT_TIME=2.5s # TO RESTART NEXT
TIMEOUT=16 # DNS
TRIES=8
HOST=localhost
PORT=5053
EDNS=174.53.130.17

QUERY=www.google.com

EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    exit
fi

# Examples
# dig @127.0.0.1 -p 5053 +tries=3 +dnssec +ttl +edns +timeout=4

if ! command -v grepip &> /dev/null
then
    echo "COMMAND dig could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT"

dns_unbound_local=`dig $QUERY -p $PORT $isAuto @$HOST $DNS_ARGS`

dns_local_test=`echo "$dns_unbound_local" | grepip --ipv4 -o | xargs`


log_d "NET_IP $NET_IP"
log_d "IP_REGEX NET_DEVICE_REGEX :$NET_DEVICE_REGEX: :$IP_REGEX:"
log_d "EXCLUDE_IP ROOT_NETWORK DNS_IP :$EXCLUDE_IP: :$ROOT_NETWORK: :$DNS_IP:"
log_d "dns_local dns_master dns_global :$dns_local: :$dns__master: :$dns_global:"
log_d "result dns_local_test :$dns_local_test:"

if [[ -z "$isAuto" ]]; then
        echo -e "LOCAL \n$(bash $PROG/lines.sh '*')"
	printf '%s\n' "$dns_local"
else
	if [[ -z "$dns_local_test" ]] && [[ `systemctl-seconds unbound` -ge 45 ]]; then
		systemctl restart unbound.service
		sleep $WAIT_TIME
	else
		echo "Test DNS Unbound Success"
	fi
fi
