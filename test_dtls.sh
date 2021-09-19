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
[[ "$1" == "-a" ]] && isAuto="+short" || isAuto='-d'
# kdig -d @dns.google +tls-ca +tls-host=dns.google www.google.com +timeout=4 +dnssec +edns
# kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @10.128.0.9 +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @aws.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns

# TO RESTART NEXT
WAIT_TIME=16.5s
# DNS
TIMEOUT=16
TRIES=4
HOST=dns.ctptech.dev

local_interface=ctp-vpn.local
server_input=${2}
server=${server_input:=$local_interface}
QUERY=${3:-www.google.com}

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
    exit 1
fi

DTLS_ARGS="+dnssec +edns +ttl +tls-hostname=$HOST +retry=$TRIES +timeout=$TIMEOUT +tcp -4 -t A +notcp"
if [[ $server == $local_interface ]] || [[ '-a' != $1 ]]; then
        echo "Running DNS TEST"
fi

EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`

DTLS=`kdig @$HOST $isAuto $QUERY $DTLS_ARGS`
DTLS_local=`kdig @$server $isAuto $QUERY $DTLS_ARGS`
DTLS_master=`kdig @master.$HOST $isAuto $QUERY $DTLS_ARGS`
DTLS_external=`kdig @$EXTENRAL_IP $isAuto $QUERY $DTLS_ARGS`


log_d "NET_IP $NET_IP"
log_d "IP_REGEX NET_DEVICE_REGEX :$NET_DEVICE_REGEX: :$IP_REGEX:"
log_d "EXCLUDE_IP ROOT_NETWORK DNS_IP :$EXCLUDE_IP: :$ROOT_NETWORK: :$DNS_IP:"

if [[ "$isAuto" == "-d"  ]]; then
	echo -e "EXTERNAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$DTLS"
	echo -e "MASTER \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$DTLS_master"
	echo -e "EXTENRAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$DTLS_external"
	echo -e "LOCAL \n$(bash $PROG/lines.sh '*')\n"
	printf '%s\n' "$DTLS_local"
elif [[ $(systemctl-inbetween-status ctp-dns.service) == 'false' ]]; then
	dns_local=`dig $QUERY @ctp-vpn.local +short +tries=$TRIES +dnssec +timeout=$TIMEOUT +retry=$TRIES`
	dns_local_test=`echo "$dns_local" | grepip --ipv4 -o`

    	DTLS_test=`echo "$DTLS" | grepip --ipv4 -o`
	DTLS_local_test=`echo "$DTLS_local" | grepip --ipv4 -o`
	DTLS_external_test=`echo "$DTLS_external" | grepip --ipv4 -o`

	if [[ -z "$DTLS_local_test" ]]; then
		if [[ $server == $local_interface ]]; then
			echo "DTLS FAILED DTLS_local_test :$DTLS_local_test:"
			if [[ -z "$dns_local_test" ]]; then
				echo "DNS FAILED NOT DTLS"
				exit 1
				kill $$
			fi
			if [[ `systemctl-seconds ctp-dns.service` -gt 15 ]]; then
				echo "restarting DTLS"
				ctp-dns.sh --generate-config
				systemctl daemon-reload
			        systemctl restart ctp-dns
				#sleep $WAIT_TIME
			fi
		else
			echo "false"
		fi
  	elif [[ -z "$DTLS_external_test" ]]; then
		if [[ -z "$dns_local_test" ]]; then
			debug_log "DNS FAILED NOT DTLS"
			exit 1
		fi
                echo "DTLS: extenal failed posiable firewall issue"
                echo "DTLS: extenal failed posiable firewall issue"
                echo "RUNNING FAIL2BAN SCRIPT"
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
                echo "DONE FAIL2BAN SCRIPT"
                echo "DTLS: extenal failed posiable firewall issue"
                echo "DTLS: extenal failed posiable firewall issue"
	else
		echo "DTLS SUCCESS"
	fi
fi
