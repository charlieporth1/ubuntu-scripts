#!/bin/bash
source $PROG/all-scripts-exports.sh
source ctp-dns.sh --source
CONCURRENT

if [[ -f $CTP_DNS_LOCK_FILE ]]; then
        echo "LOCK FILE"
        trap 'LOCK_FILE' ERR
        set -e
        exit 1
        exit 1
fi
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/charlieporth1_gmail_com/go/bin:$PATH
echo "Running DNS TEST"
[[ "$1" == "-a" ]] && isAuto="+short"

WAIT_TIME=16.5s # TO RESTART NEXT
TIMEOUT=16 # DNS
TRIES=4
HOST=dns.ctptech.dev

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
    sudo apt install dnsutils
    exit 1
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
    exit 1
fi

DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT -t A -4 +retry=$TRIES +ttlunits"

dns_global=`dig $QUERY $isAuto @$HOST $DNS_ARGS`
dns_master=`dig $QUERY $isAuto @master.$HOST $DNS_ARGS`
dns_local=`dig $QUERY $isAuto @ctp-vpn.local $DNS_ARGS`
dns_external=`dig $QUERY $isAuto @$EXTENRAL_IP $DNS_ARGS`

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
		echo "DNS Failed"
		pihole_bin=$( which pihole || echo '/usr/local/bin/pihole' )
		service=pihole-FTL.service
		if [[ -f "$pihole_bin" ]] || [[ `systemctl-exists $service` ]]; then
			if [[ $(systemctl-inbetween-status $service) == 'false' ]] && [[ `systemctl-seconds $service` -gt 30 ]]; then
				echo "DNS Failed restarting pihole_bin :$pihole_bin:"
				echo "restarting pihole"
				PIHOLE_RESTART_PRE
				pihole restartdns
				PIHOLE_RESTART_POST 3
				#sleep $WAIT_TIME
			fi
		elif [[ $(systemctl-inbetween-status ctp-dns.service) == 'false' ]];  then
			if [[ `systemctl-seconds ctp-dns.service` -gt 30 ]]; then
		                echo "restarting ctp-dns"
				ctp-dns.sh --generate-config
				systemctl daemon-reload
				systemctl restart ctp-dns
				#sleep $WAIT_TIME
			fi
		fi
	elif [[ -z "$dns_external_test" ]]; then
		echo "DNS: extenal failed posiable firewall issue"
		echo "DNS: extenal failed posiable firewall issue"
		echo "RUNNING FAIL2BAN SCRIPT"
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
		echo "DONE FAIL2BAN SCRIPT"
		echo "DNS: extenal failed posiable firewall issue"
		echo "DNS: extenal failed posiable firewall issue"
	else
		echo "Test DNS Success"
	fi
fi
