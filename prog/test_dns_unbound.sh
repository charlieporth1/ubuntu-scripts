#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/charlieporth1_gmail_com/go/bin:$PATH
echo "Running DNS TEST"
[[ "$1" == "-a" ]] && isAuto="+short"

WAIT_TIME=2.5s # TO RESTART NEXT
TIMEOUT=16 # DNS
TRIES=8
HOST=localhost
PORT=5053
EDNS=174.53.130.17

QUERY=www.google.com

DNS_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh))
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"

#EXCLUDE_IP=${EXCLUDE_IP//./\\.}
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    exit
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND dig could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT"

dns_unbound_local=`dig www.google.com -p Y $isAuto @$HOST $DNS_ARGS`

dns_local_test=`echo "$dns_local" | grepip --ipv4 -o | xargs`
dns_external_test=`echo "$dns_external" | grepip --ipv4 -o | xargs`


log_d "NET_IP $NET_IP"
log_d "IP_REGEX NET_DEVICE_REGEX :$NET_DEVICE_REGEX: :$IP_REGEX:"
log_d "EXCLUDE_IP ROOT_NETWORK DNS_IP :$EXCLUDE_IP: :$ROOT_NETWORK: :$DNS_IP:"
log_d "dns_local dns_master dns_global :$dns_local: :$dns__master: :$dns_global:"
log_d "result dns_local_test :$dns_local_test:"

if [[ -z "$isAuto" ]]; then
	echo -e "GLOBAL \n$(bash $PROG/lines.sh '*')"
	printf '%s\n' "$dns_global"
	echo -e "MASTER \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_master"
	echo -e "EXTERNAL \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$dns_external"
        echo -e "LOCAL \n$(bash $PROG/lines.sh '*')"
	printf '%s\n' "$dns_local"
else
	if [[ -z "$dns_local_test" ]]; then
		pihole_bin=[[ -n `which pihole` ]] && `which pihole` || /usr/local/bin/pihole
		echo "Failed restarting pihole_bin :$pihole_bin:"
		isSystemInactivePiHole=`systemctl status pihole-FTL | grep -oE '(de|)activating'`
		isSystemInactiveCTP=`systemctl status ctp-dns | grep -oE '(de|)activating'`
		if [[ -f "$pihole_bin" ]] && [[ -z "$isSystemInactivePiHole" ]]; then
			echo "restarting pihole"
			pihole restartdns
			IF_RESTART
			IF_RESTART
			IF_RESTART
			sleep $WAIT_TIME
		elif [[ -z "$isSystemInactiveCTP" ]];  then
	                echo "restarting ctp-dns"
			systemctl daemon-reload
			systemctl restart ctp-dns
			sleep $WAIT_TIME
		fi
	else
		echo "Test DNS Success"
	fi
	if [[ -z "$dns_external_test" ]]; then
		echo "DNS: extenal failed posiable firewall issue"
	fi
fi
