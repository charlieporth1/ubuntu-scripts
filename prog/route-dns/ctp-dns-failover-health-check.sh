#!/bin/bash
source /etc/environment
source ctp-dns.sh --source
source $PROG/all-scripts-exports.sh
echo "Date last open `date` $scriptName"
OUT_FILE=$FAIL_ROUTE/$HOSTNAME-resolvers.toml

export LOCAL_RESOLVER_NAME='ctp-dns-local-master'

DEFAULT_SERVICE=ctp-dns.service
FAIL_SERVICE=ctp-fail-over-dns.service

function gen_listen() {
	REPLACE_IP=`bash $PROG/get_network_devices_ip_address.sh`
	DEFAULT_IP='0.0.0.0'
	sudo cp -rf $ROUTE/standard-listeners.toml $FAIL_ROUTE
	# sudo cp -rf $ROUTE/rate-limiter.toml $FAIL_ROUTE

echo """# Generated by: $scriptName
# Generated at: `date`


""" | sudo tee $OUT_FILE
IFS=$'\n'

for ip in $REPLACE_IP
do
	resolver=$LOCAL_RESOLVER_NAME-${REPLACE_IP//\./-}
	if dig @$ip www.google.com > /dev/null; then

echo """
[resolvers.$resolver-tcp]
address = \"$ip:53\"
protocol = \"tcp\"
[resolvers.$resolver-udp]
address = \"$ip:53\"
protocol = \"udp\"
edns0-udp-size = 1460

[groups.$resolver-truncate-retry]
type = \"truncate-retry\"
resolvers = [ \"$resolver-udp\" ]
retry-resolver = \"$resolver-tcp\"

""" | sudo tee -a $OUT_FILE

	fi

done

export LOCAL_RESOLVERS_LIST=$(grep -E "^.(resolvers|groups)\..*$LOCAL_RESOLVER_NAME.*" $OUT_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
export LOCAL_RESOLVERS=$(new_linify $(csvify $(printf '%s\n' "$LOCAL_RESOLVERS_LIST" ) --quotes --space))


echo """
[groups.ctp-dns-group]
type = \"fail-back\"
resolvers = [
	$LOCAL_RESOLVERS,
]
reset-after = 6
servfail-error = true

[groups.ctp-dns-group-local]
type = \"fail-back\"
resolvers = [
	$LOCAL_RESOLVERS,
]
reset-after = 6
servfail-error = true

""" | sudo tee -a $OUT_FILE

}

function cleanup() {
	rm -rf $FAIL_ROUTE/ctp-dns-{fastest-tcp-probe,back-up-resolvers}.toml
	rm -rf $FAIL_ROUTE/{ctp-local-doh-listener-for-nginx,phishing-blocklist,ctp-vpn-listenrs}.toml
	rm -rf $FAIL_ROUTE/$HOSTNAME*.toml
}

function start_failover() {
	echo "Starting failover config"
	echo `date`
	source $PROG/generate_ctp-dns-envs.sh
	format_file $ROUTE/*.toml
	gen_listen
	echo "Stoping $DEFAULT_SERVICE"
	systemctl stop $DEFAULT_SERVICE
        systemctl unmask $DEFAULT_SERVICE

	echo "Starting $FAIL_SERVICE"
	systemctl unmask $FAIL_SERVICE
	systemctl start $FAIL_SERVICE

}
function stop_failover() {
	echo "Stopping failover config"
	echo `date`
    	echo "Stop $FAIL_SERVICE"

        systemctl stop $FAIL_SERVICE
        systemctl disable $FAIL_SERVICE
        systemctl mask $FAIL_SERVICE

        echo "Starting $DEFAULT_SERVICE"
        systemctl unmask $DEFAULT_SERVICE
        systemctl enable $DEFAULT_SERVICE
	systemctl start $DEFAULT_SERVICE
}

if [[ -d $FAIL_ROUTE/ ]] && [[ `systemctl-exists $FAIL_SERVICE` == 'true' ]]; then
    if [[ `systemctl-inbetween-status $DEFAULT_SERVICE` == 'true' ]] || [[ `systemctl-is-failed $DEFAULT_SERVICE` == 'true' ]]; then
        if [[ `config_test $FAIL_ROUTE` == 'true' ]] && [[ `ctp-dns.sh --config-test` == 'false' ]] ; then
		start_failover
	elif [[ `config_test $FAIL_ROUTE` == 'true' ]] && [[ `ctp-dns.sh --config-test` == 'true' ]]; then
		stop_failover
	elif [[ `config_test $FAIL_ROUTE` == 'false' ]]; then
		gen_listen
		source $PROG/generate_ctp-dns-envs.sh
                format_file $FAIL_ROUTE/*.toml
		cleanup
        fi
    elif [[ `systemctl-is-failed $DEFAULT_SERVICE` == 'false' ]] || [[ `systemctl-inbetween-status $DEFAULT_SERVICE` == 'false' ]] || [[ `ctp-dns.sh --config-test` == 'true' ]]; then
		stop_failover
    fi
else
	echo "Failover not setup properly check systemd or dir"
fi


