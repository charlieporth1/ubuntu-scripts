#!/bin/bash
source $PROG/test_dns_args.sh $@
CONCURRENT

dns_logger "Running DNS BLOCK TEST"

QUERY=www.ads.com

WAIT_TIME=2.5s # TO RESTART NEXT
HOST=dns.ctptech.dev


MASTER_DNS_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh "master.$HOST"))

if ! command -v dig &> /dev/null
then
    echo "COMMAND could not be found"
    exit
fi

dns_local=`dig $QUERY @ctp-vpn.local $isAuto +timeout=$TIMEOUT +tries=$TRIES +dnssec +short`
dns_master=`dig $QUERY @master.$HOST $isAuto +timeout=$TIMEOUT +tries=$TRIES +dnssec +short`

dns_local_test=`echo "$dns_local" | grep -o "$MASTER_DNS_IP\|192.168.44.250" | xargs`
dns_master_test=`echo "$dns_master" | grep -o "$MASTER_DNS_IP\|192.168.44.250" | xargs`


if [[ -z "$isAuto" ]]; then
        echo "MASTER \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_master"
        echo "LOCAL \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_local"
else
        if [[ -z "$dns_local_test" ]] && [[ -n "$dns_master_test" ]] && \
	[[ "$dns_local_test" != "$dns_master_test" ]]
	then
		if_plain_dns_fail
                dns_logger "DNS block test failed: restarting"
			systemctl daemon-reload
                        systemctl restart ctp-dns
        else
                dns_logger "Test DNS Block Success"
        fi
fi
