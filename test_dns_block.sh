#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
echo "Running DNS BLOCK TEST"
[[ "$1" == "-a" ]] && isAuto="+short"

QUERY=www.ads.com

WAIT_TIME=2.5s # TO RESTART NEXT
TIMEOUT=3 # DNS
TRIES=2
HOST=dns.ctptech.dev

IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"

MASTER_DNS_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh "master.$HOST"))
CURRENT_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh --current-ip))

ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`

EXCLUDE_IP="$ROOT_NETWORK\|$CURRENT_IP\|0.0.0.0"
if ! command -v dig &> /dev/null
then
    echo "COMMAND could not be found"
    exit
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND dig could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

dns_local=`dig $QUERY @ctp-vpn.local $isAuto +timeout=$TIMEOUT +tries=$TRIES +dnssec +short`
dns_master=`dig $QUERY @master.$HOST $isAuto +timeout=$TIMEOUT +tries=$TRIES +dnssec +short`

dns_local_test=`echo "$dns_local" | grep -o "$MASTER_DNS_IP\|192.168.44.250" | xargs`
dns_master_test=`echo "$dns_master" | grep -o "$MASTER_DNS_IP\|192.168.44.250" | xargs`

isSystemInactiveCTP=`systemctl status ctp-dns | grep -oE '(de|)activating'`

if [[ -z "$isAuto" ]]; then
        echo "MASTER \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_master"
        echo "LOCAL \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_local"
else
        if [[ -z "$dns_local_test" ]] && [[ -n "$dns_master_test" ]] && \
	[[ "$dns_local_test" != "$dns_master_test" ]]
	then
                echo "DNS block test failed: restarting"
                        systemctl restart ctp-dns
        else
                echo "Test DNS Block Success"
        fi
fi
