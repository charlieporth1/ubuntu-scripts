#!/bin/bash
source $PROG/all-scripts-exports.sh
https_port=443
web_service=nginx.service
port_status=`ss -alunt "sport = :$https_port" | grep -o "$https_port" | sort -u`
fn=$web_service
function _start_web_server() {
	(
		local MSG="Web Service had to be spun up Please check NGINX ASAP "
		echo $MSG
		echo $MSG
		bash $PROG/alert_user.sh $MSG
		bash $PROG/alert_user.sh $MSG
	)&
	(
		cd $WWW
		echo "Going to $WWW to start webserver"
		echo $PWD
		sleep 0.5s
		sudo python3 $PROG/simple-failover-http-server.py
	)&
}

if [[ $HOSTNAME == ctp-vpn ]]; then
	if [[ -z $port_status ]] && [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		service_status=`systemctl-is-failed $fn`
		if systemctl is-failed --quiet $fn; then
			_start_web_server
		elif [[ "$service_status" == 'true' ]]; then
			_start_web_server
		else
			echo "NGINX Looks good starting CTP-DNS Service"
		fi
	fi
fi
