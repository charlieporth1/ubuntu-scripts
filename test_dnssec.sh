#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
QUERY=dnssec-tools.org
WAIT_TIME=16.5s # TO RESTART NEXT
TIMEOUT=24 # DNS
TRIES=8
HOST=dns.ctptech.dev

EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`

declare -a dns_servers
dns_servers=("1.1.1.1" "8.8.8.8" "ctp-vpn.local" "$EXTENRAL_IP")

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    exit
fi


for dns_server in "${dns_servers[@]}"
do
	result=`dig +dnssec $QUERY @$dns_server +timeout=$TIMEOUT +tries=$TRIES +edns -t A -4 +retry=$TRIES | grep -o 'ad'`
	echo $result
	if [[ -z "$result" ]]; then
		echo "FAIL AT $dns_server"
		bash $PROG/alert_user.sh "DNSSEC test failed for sever $dns_server; please check $HOSTNAME;; $result;;"
		sleep $WAIT_TIME
	fi
done
