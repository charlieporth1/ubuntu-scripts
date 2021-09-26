#!/bin/bash
source $PROG/test_DNS UDP_args.sh
CONCURRENT

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    sudo apt install DNS UDPutils
    exit 1
fi

DNS UDP_ARGS="+tries=$TRIES +DNS UDPsec +ttl +eDNS UDP +timeout=$TIMEOUT -t $qtype -4 +retry=$TRIES +ttlunits +notcp"

DNS UDP_global=`dig $QUERY $isAuto @$HOST $DNS UDP_ARGS`
DNS UDP_master=`dig $QUERY $isAuto @master.$HOST $DNS UDP_ARGS`
DNS UDP_local=`dig $QUERY $isAuto @$server $DNS UDP_ARGS`
DNS UDP_external=`dig $QUERY $isAuto @$EXTENRAL_IP $DNS UDP_ARGS`

DNS UDP_local_test=`echo "$DNS UDP_local" | grepip --ipv4 -o | xargs`
DNS UDP_external_test=`echo "$DNS UDP_external" | grepip --ipv4 -o | xargs`

DNS UDP_logger "Running DNS UDP TEST"

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
		DNS UDP_logger "DNS UDP Failed"
		pihole_bin=$( which pihole || echo '/usr/local/bin/pihole' )
		service=pihole-FTL.service
		if [[ "$server" == "$local_interface" ]] && [[ '-a' != "$1" ]]; then
			if [[ -f "$pihole_bin" ]] || [[ `systemctl-exists $service` ]]; then
				if [[ $(systemctl-inbetween-status $service) == 'false' ]]; then
					DNS UDP_logger "DNS UDP Failed restarting pihole_bin :$pihole_bin:"
					DNS UDP_logger "restarting pihole"
					PIHOLE_RESTART_PRE
					pihole restartDNS UDP
					PIHOLE_RESTART_POST 3
					#sleep $WAIT_TIME
				fi
				elif [[ $(systemctl-inbetween-status ctp-DNS UDP.service) == 'false' ]]; then
					if [[ `systemctl-seconds ctp-DNS UDP.service` -gt 30 ]]; then
				                DNS UDP_logger "restarting ctp-DNS UDP"
						ctp-DNS UDP.sh --generate-log
						ctp-DNS UDP.sh --generate-config
						systemctl daemon-reload
						systemctl restart ctp-DNS UDP
						#sleep $WAIT_TIME
					fi
				fi
		else
			run_fail_automation_action
		fi
	elif [[ -z "$DNS UDP_external_test" ]]; then
		DNS UDP_logger "DNS UDP: extenal failed posiable firewall issue"
		DNS UDP_logger "DNS UDP: extenal failed posiable firewall issue"
		DNS UDP_logger "RUNNING FAIL2BAN SCRIPT"
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/set_unban_ip.sh > /dev/null
                sudo cgexec -g cpu:cpulimited /bin/bash $PROG/search_for_unban_ip.sh > /dev/null
		DNS UDP_logger "DONE FAIL2BAN SCRIPT"
		DNS UDP_logger "DNS UDP: extenal failed posiable firewall issue"
		DNS UDP_logger "DNS UDP: extenal failed posiable firewall issue"
	else
		DNS UDP_logger "Test DNS UDP Success"
	fi
fi
