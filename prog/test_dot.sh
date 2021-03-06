#!/bin/bash
if [[ -f /tmp/health-checks.stop.lock ]]; then
        echo "LOCK FILE"
	trap 'LOCK_FILE' ERR
        set -e
        exit 1
        exit 1
fi
source $PROG/all-scripts-exports.sh
CONCURRENT
echo "Running DOT TEST"
[[ "$1" == "-a" ]] && isAuto="+short" || isAuto='-d'
QUERY=www.google.com
# kdig -d @dns.google +tls-ca +tls-host=dns.google www.google.com +timeout=4 +dnssec +edns
# kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @aws.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns

# TO RESTART NEXT
WAIT_TIME=16.5s
# DNS
TIMEOUT=64
TRIES=18
HOST=dns.ctptech.dev

EDNS=174.53.130.17

DNS_IP=`$PROG/grepify.sh $(bash $PROG/get_ext_ip.sh)`
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"

if ! command -v kdig &> /dev/null
then
    echo "COMMAND kdig could not be found"
    exit
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

DOT_ARGS="+dnssec +edns +ttl +tls-hostname=$HOST +retry=$TRIES +timeout=$TIMEOUT +tcp -4 -t A"

EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`

dot=`kdig @$HOST $isAuto $QUERY $DOT_ARGS`
dot_local=`kdig @ctp-vpn.local $isAuto $QUERY $DOT_ARGS`
dot_master=`kdig @master.$HOST $isAuto $QUERY $DOT_ARGS`
dot_external=`kdig @$EXTENRAL_IP $isAuto $QUERY $DOT_ARGS`


log_d "NET_IP $NET_IP"
log_d "IP_REGEX NET_DEVICE_REGEX :$NET_DEVICE_REGEX: :$IP_REGEX:"
log_d "EXCLUDE_IP ROOT_NETWORK DNS_IP :$EXCLUDE_IP: :$ROOT_NETWORK: :$DNS_IP:"

if [[ "$isAuto" == "-d"  ]]; then
	echo -e "EXTERNAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$dot"
	echo -e "MASTER \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$dot_master"
	echo -e "EXTENRAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$dot_external"
	echo -e "LOCAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$dot_local"
elif [[ $(systemctl-inbetween-status ctp-dns.service) == false ]]; then
	dns_local=`dig $QUERY @ctp-vpn.local +short +tries=$TRIES +dnssec +timeout=$TIMEOUT`
	dns_local_test=`echo "$dns_local" | grepip --ipv4 -o`

    	dot_test=`echo "$dot" | grepip --ipv4 -o`
	dot_local_test=`echo "$dot_local" | grepip --ipv4 -o`
	dot_external_test=`echo "$dot_external" | grepip --ipv4 -o`

	if [[ -z "$dot_local_test" ]]; then
		echo "DOT FAILED dot_local_test :$dot_local_test:"
		if [[ -z "$dns_local_test" ]]; then
			echo "DNS FAILED NOT DOT"
			exit 1
		fi

		echo "restarting DOT"
		systemctl daemon-reload
	        systemctl restart ctp-dns
		sleep $WAIT_TIME

  	elif [[ -z "$dot_external_test" ]]; then
		if [[ -z "$dns_local_test" ]]; then
			echo "DNS FAILED NOT DOT"
			exit 1
		fi
                echo "DOT: extenal failed posiable firewall issue"
                echo "DOT: extenal failed posiable firewall issue"
                echo "RUNNING FAIL2BAN SCRIPT"
                bash $PROG/set_fail2ban-defaults.sh > /dev/null
                echo "DONE FAIL2BAN SCRIPT"
                echo "DOT: extenal failed posiable firewall issue"
                echo "DOT: extenal failed posiable firewall issue"
	else
		echo "DOT SUCCESS"
	fi
fi
