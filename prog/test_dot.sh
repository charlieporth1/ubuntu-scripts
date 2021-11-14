#!/bin/bash
source $PROG/test_dns_args.sh $@
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

DOT_ARGS="+dnssec +edns +ttl +tls +tls-hostname=$HOST +tls-ca +retry=$TRIES +timeout=$TIMEOUT +tcp -4 -t $qtype"

dns_logger "Running DoT TEST"

dot=`kdig @$HOST $isAuto $QUERY $DOT_ARGS`
dot_local=`kdig @$server $isAuto $QUERY $DOT_ARGS`
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
elif [[ $(systemctl-inbetween-status ctp-dns.service) == 'false' ]]; then

    	dot_test=`echo "$dot" | grepip --ipv4 -o`
	dot_local_test=`echo "$dot_local" | grepip --ipv4 -o`
	dot_external_test=`echo "$dot_external" | grepip --ipv4 -o`

	if [[ -z "$dot_local_test" ]]; then
		if_plain_dns_fail
		if [[ $server == $local_interface ]] && [[ -n "$isAuto" ]]; then
			dns_logger "DOT FAILED dot_local_test :$dot_local_test:"

			if [[ `systemctl-seconds ctp-dns.service` -gt 15 ]]; then
				dns_logger "restarting DOT"
				ctp-dns.sh --generate-logs
				ctp-dns.sh --generate-config
				systemctl daemon-reload
			        systemctl restart ctp-dns
				#sleep $WAIT_TIME
			fi
		else
			echo "false"
		fi
  	elif [[ -z "$dot_external_test" ]]; then
		if_plain_dns_fail
                dns_logger "DOT: extenal failed posiable firewall issue"
                dns_logger "DOT: extenal failed posiable firewall issue"
                dns_logger "RUNNING FAIL2BAN SCRIPT"
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
		sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
                dns_logger "DONE FAIL2BAN SCRIPT"
                dns_logger "DOT: extenal failed posiable firewall issue"
                dns_logger "DOT: extenal failed posiable firewall issue"
	else
		dns_logger "DoT SUCCESS"
	fi
fi
