#!/bin/bash
source $PROG/test_dns_args.sh $@
CONCURRENT
dns_logger "Running DNS Refresh TEST"

if ! command -v kdig &> /dev/null
then
    echo "COMMAND kdig could not be found"
    exit
fi

DNS_ARGS="+dnssec +edns +ttl +retry=$TRIES +timeout=$TIMEOUT -4 -t $qtype $isAuto"
DOT_ARGS="$DNS_ARGS +tls +tls-hostname=$HOST +tls-ca +tcp"

NOT_CTP_DNS=`dig $HOST $DNS_ARGS`
CTP_DNS=`dig $HOST @ctp-vpn.local $DNS_ARGS`
CTP_DNS_ENCRYPTED=`kdig $HOST @ctp-vpn.local`


if [[ -z "$isAuto" ]]; then
        echo -e "NOT_CTP_DNS \n$(bash $PROG/lines.sh '*')\n"
        printf '%s\n' "$NOT_CTP_DNS"
        echo -e "CTP_DNS \n$(bash $PROG/lines.sh '*')\n"
        printf '%s\n' "$CTP_DNS"
        echo -e "CTP_DNS_ENCRYPTED \n$(bash $PROG/lines.sh '*')\n"
        printf '%s\n' "$CTP_DNS_ENCRYPTED"
        echo -e "\n$(bash $PROG/lines.sh '*')\n"

fi
