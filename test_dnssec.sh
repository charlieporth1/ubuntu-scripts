#!/bin/bash
declare -a dns_servers
dns_servers=("8.8.8.8" "pihole.local" "ctp-vpn.local" "vpn.ctptech.dev")
for dns_server in ${dns_servers[@]}
do
	result=`dig +dnssec dnssec-tools.org @$dns_server +timeout=3 | grep ad`
	if [[ -z $result ]]; then
		echo FAIL AT $dns_server
		bash $PROG/alert_user.sh "DNSSEC test failed for sever $dns_server; please check"
		sleep 2s
	fi
done
