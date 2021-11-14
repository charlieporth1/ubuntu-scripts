#!/bin/bash
source $PROG/test_dns_args.sh $@
CONCURRENT

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    sudo apt install dnsutils
    exit 1
fi

DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT -t $qtype -4 +retry=$TRIES +ttlunits"

dns_global=`dig $QUERY $isAuto @$HOST $DNS_ARGS`
dns_master=`dig $QUERY $isAuto @master.$HOST $DNS_ARGS`
dns_local=`dig $QUERY $isAuto @$server $DNS_ARGS`
dns_external=`dig $QUERY $isAuto @$EXTENRAL_IP $DNS_ARGS`

dns_local_test=`echo "$dns_local" | grepip --ipv4 -o | xargs`
dns_external_test=`echo "$dns_external" | grepip --ipv4 -o | xargs`

dns_logger "Running DNS TEST"

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
		dns_logger "DNS Failed"
		pihole_bin=$( which pihole || echo '/usr/local/bin/pihole' )
		service=pihole-FTL.service
		if [[ "$server" == "$local_interface" ]] && [[ '-a' != "$1" ]]; then
			if [[ -f "$pihole_bin" ]] || [[ `systemctl-exists $service` ]]; then
				if [[ $(systemctl-inbetween-status $service) == 'false' ]]; then
					dns_logger "DNS Failed restarting pihole_bin :$pihole_bin:"
					dns_logger "restarting pihole"
					PIHOLE_RESTART_PRE
					pihole restartdns
					PIHOLE_RESTART_POST 3
					#sleep $WAIT_TIME
				fi
				elif [[ $(systemctl-inbetween-status ctp-dns.service) == 'false' ]]; then
					if [[ `systemctl-seconds ctp-dns.service` -gt 30 ]]; then
				                dns_logger "restarting ctp-dns"
						ctp-dns.sh --generate-log
						ctp-dns.sh --generate-config
						systemctl daemon-reload
						systemctl restart ctp-dns
						#sleep $WAIT_TIME
					fi
				fi
		else
			run_fail_automation_action
		fi
	elif [[ -z "$dns_external_test" ]]; then
		dns_logger "DNS: extenal failed posiable firewall issue"
		dns_logger "DNS: extenal failed posiable firewall issue"
		dns_logger "RUNNING FAIL2BAN SCRIPT"
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
		dns_logger "DONE FAIL2BAN SCRIPT"
		dns_logger "DNS: extenal failed posiable firewall issue"
		dns_logger "DNS: extenal failed posiable firewall issue"
	else
		dns_logger "Test DNS Success"
	fi
fi
