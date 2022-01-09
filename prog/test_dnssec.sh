#!/bin/bash
source $PROG/test_dns_args.sh
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

file=/tmp/root.keys
for dns_server in "${dns_servers[@]}"
do
	dig . DNSKEY @$dns_server | grep -Ev '^($|;)' > $file
	result=`dig +sigchase +trusted-key=./root.keys A $QUERY`
	result_ctp=`dig +sigchase +trusted-key=./root.keys A $HOST`
	dns_logger "result $result dns_server $dns_server $result_ctp"
	if [[ -z "$result" ]] || [[ -z "$result_ctp" ]]; then
		dns_logger "FAIL AT $dns_server with result $result $result_ctp"
		bash $PROG/alert_user.sh "DNSSEC test failed for sever $dns_server; please check $HOSTNAME;; $result, $result_ctp;;"
		#sleep $WAIT_TIME
	fi
done
