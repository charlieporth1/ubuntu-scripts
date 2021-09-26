#!/bin/bash
source $PROG/all-scripts-exports.sh --no-log
CONCURRENT
QUERY=dnssec-tools.org

declare -a dns_servers
dns_servers=(
	"1.1.1.1"
	"8.8.8.8"
	"ctp-vpn.local"
	"$EXTENRAL_IP"
)

if ! command -v dig &> /dev/null
then
    echo "COMMAND dig could not be found"
    exit
fi


for dns_server in "${dns_servers[@]}"
do
	result=`dig +dnssec $QUERY @$dns_server +timeout=$TIMEOUT +tries=$TRIES +edns -t $qtype -4 +retry=$TRIES | grep -o 'ad'`
	dns_logger "result $result dns_server $dns_server"
	if [[ -z "$result" ]]; then
		dns_logger "FAIL AT $dns_server with result $result"
		bash $PROG/alert_user.sh "DNSSEC test failed for sever $dns_server; please check $HOSTNAME;; $result;;"
		#sleep $WAIT_TIME
	fi
done
