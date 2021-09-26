#!/bin/bash
source $PROG/test_dns_args.sh
CONCURRENT

if [[ `systemctl-exists unbound.service` == false ]]; then
	exit 1
	kill -9 $$
fi
dns_logger "Running DNS Unbound TEST"

TRIES=3
HOST=localhost
PORT=5053

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    exit
fi

fi

DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT -t $qtype -4"

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
	if [[ -z "$dns_local_test" ]] && [[ `systemctl-seconds unbound` -ge 30 ]]; then
		systemctl restart unbound.service
		#sleep $WAIT_TIME
	else
		dns_logger "Test DNS Unbound Success"
	fi
fi
