#!/bin/bash
source $PROG/test_dns_args.sh
CONCURRENT
[[ "$1" == "-a" ]] && isAuto="+short" || isAuto='-d'
# kdig -d @dns.google +tls-ca +tls-host=dns.google www.google.com +timeout=4 +dnssec +edns
# kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @10.128.0.9 +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
# kdig -d @aws.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns

# TO RESTART NEXT
if ! command -v kdig &> /dev/null
then
    echo "COMMAND kdig could not be found"
    exit
fi

DTLS_ARGS="+dnssec +edns +ttl +tls-hostname=$HOST +retry=$TRIES +timeout=$TIMEOUT +tcp -4 -t $qtype +notcp"

dns_logger "Running DTLS TEST"

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

    	DTLS_test=`echo "$DTLS" | grepip --ipv4 -o`
	DTLS_local_test=`echo "$DTLS_local" | grepip --ipv4 -o`
	DTLS_external_test=`echo "$DTLS_external" | grepip --ipv4 -o`

	if [[ -z "$DTLS_local_test" ]]; then
		if_plain_dns_fail
		if [[ $server == $local_interface ]] && [[ -n "$isAuto" ]]; then
			dns_logger "DTLS FAILED DTLS_local_test :$DTLS_local_test:"

			if [[ `systemctl-seconds ctp-dns.service` -gt 15 ]]; then
				dns_logger "restarting DTLS"
				ctp-dns.sh --generate-logs
				ctp-dns.sh --generate-config
				systemctl daemon-reload
			        systemctl restart ctp-dns
				#sleep $WAIT_TIME
			fi
		else
			echo "false"
		fi
  	elif [[ -z "$DTLS_external_test" ]]; then
		if_plain_dns_fail
                dns_logger "DTLS: extenal failed posiable firewall issue"
                dns_logger "DTLS: extenal failed posiable firewall issue"
                dns_logger "RUNNING FAIL2BAN SCRIPT"
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
                dns_logger "DONE FAIL2BAN SCRIPT"
                dns_logger "DTLS: extenal failed posiable firewall issue"
                dns_logger "DTLS: extenal failed posiable firewall issue"
	else
		dns_logger "DTLS SUCCESS"
	fi
fi
