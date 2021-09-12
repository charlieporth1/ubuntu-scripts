#!/bin/bash
source $PROG/all-scripts-exports.sh
source ctp-DNS UDP.sh --source
CONCURRENT

if [[ -f $CTP_DNS UDP_LOCK_FILE ]]; then
        echo "LOCK FILE"
        trap 'LOCK_FILE' ERR
        set -e
        exit 1
        exit 1
fi
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/charlieporth1_gmail_com/go/bin:$PATH
echo "Running DNS UDP TEST"
[[ "$1" == "-a" ]] && isAuto="+short"

WAIT_TIME=16.5s # TO RESTART NEXT
TIMEOUT=16 # DNS UDP
TRIES=4
HOST=DNS UDP.ctptech.dev

EDNS UDP=174.53.130.17

QUERY=www.google.com

DNS UDP_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh))
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS UDP_IP\|0.0.0.0\|$ROOT_NETWORK"

#EXCLUDE_IP=${EXCLUDE_IP//./\\.}
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    sudo apt install DNS UDPutils
    exit 1
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
    exit 1
fi

DNS UDP_ARGS="+tries=$TRIES +DNS UDPsec +ttl +eDNS UDP +timeout=$TIMEOUT -t A -4 +retry=$TRIES +ttlunits +notcp"

DNS UDP_global=`dig $QUERY $isAuto @$HOST $DNS UDP_ARGS`
DNS UDP_master=`dig $QUERY $isAuto @master.$HOST $DNS UDP_ARGS`
DNS UDP_local=`dig $QUERY $isAuto @ctp-vpn.local $DNS UDP_ARGS`
DNS UDP_external=`dig $QUERY $isAuto @$EXTENRAL_IP $DNS UDP_ARGS`

DNS UDP_local_test=`echo "$DNS UDP_local" | grepip --ipv4 -o | xargs`
DNS UDP_external_test=`echo "$DNS UDP_external" | grepip --ipv4 -o | xargs`


log_d "NET_IP $NET_IP"
log_d "IP_REGEX NET_DEVICE_REGEX :$NET_DEVICE_REGEX: :$IP_REGEX:"
log_d "EXCLUDE_IP ROOT_NETWORK DNS UDP_IP :$EXCLUDE_IP: :$ROOT_NETWORK: :$DNS UDP_IP:"
log_d "DNS UDP_local DNS UDP_master DNS UDP_global :$DNS UDP_local: :$DNS UDP__master: :$DNS UDP_global:"
log_d "result DNS UDP_local_test :$DNS UDP_local_test:"

if [[ -z "$isAuto" ]]; then
	echo -e "GLOBAL \n$(bash $PROG/lines.sh '*')"
	printf '%s\n' "$DNS UDP_global"
	echo -e "MASTER \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$DNS UDP_master"
	echo -e "EXTERNAL \n$(bash $PROG/lines.sh '*')"
        printf '%s\n' "$DNS UDP_external"
        echo -e "LOCAL \n$(bash $PROG/lines.sh '*')"
	printf '%s\n' "$DNS UDP_local"
else
	if [[ -z "$DNS UDP_local_test" ]]; then
		echo "DNS UDP Failed"
		pihole_bin=$( which pihole || echo '/usr/local/bin/pihole' )
		service=pihole-FTL.service
		if [[ -f "$pihole_bin" ]] || [[ `systemctl-exists $service` ]]; then
			if [[ $(systemctl-inbetween-status $service) == 'false' ]] && [[ `systemctl-seconds $service` -gt 30 ]]; then
				echo "DNS UDP Failed restarting pihole_bin :$pihole_bin:"
				echo "restarting pihole"
				PIHOLE_RESTART_PRE
				pihole restartDNS UDP
				PIHOLE_RESTART_POST 3
				#sleep $WAIT_TIME
			fi
		elif [[ $(systemctl-inbetween-status ctp-DNS UDP.service) == 'false' ]];  then
			if [[ `systemctl-seconds ctp-DNS UDP.service` -gt 30 ]]; then
		                echo "restarting ctp-DNS UDP"
				ctp-DNS UDP.sh --generate-config
				systemctl daemon-reload
				systemctl restart ctp-DNS UDP
				#sleep $WAIT_TIME
			fi
		fi
	elif [[ -z "$DNS UDP_external_test" ]]; then
		echo "DNS UDP: extenal failed posiable firewall issue"
		echo "DNS UDP: extenal failed posiable firewall issue"
		echo "RUNNING FAIL2BAN SCRIPT"
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
		echo "DONE FAIL2BAN SCRIPT"
		echo "DNS UDP: extenal failed posiable firewall issue"
		echo "DNS UDP: extenal failed posiable firewall issue"
	else
		echo "Test DNS UDP Success"
	fi
fi
