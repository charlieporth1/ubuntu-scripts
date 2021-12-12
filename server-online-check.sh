#!/bin/bash
source $PROG/all-scripts-exports.sh
echo "Running: `date`"
server="$1"
server_timeout=16
function server-health-check() {
	local server="${1:-aws.ctptech.dev}"
	local port="${2:-22}"
	if [[ `ip_exists "$server" $server_timeout eth0` = 'false' ]] && [[ `ip_exists "$server" $server_timeout eth1` = 'false' ]] || [[ `health_check_remote_port_tcp "$server" "$port"` == 'false' ]] ; then
		debug_log "Server $server is unhealthy rebooting"
		echo "false"
	else
		echo "true"
		debug_log "Server $server is healthly"
	fi
}

function reboot_timer() {
	local server="$1"
	if [[ -z "$rebooted_server_timeout" ]]; then
	#[[ $rebooted_server_timeout == $server ]] &&
		declare -gx rebooted_server_timeout=$server
		echo "true"
		(
			debug_log "Server reboot timer has started 2m $rebooted_server_timeout"
			sleep 2m
			debug_log "Server reboot timer has finished $rebooted_server_timeout"
			declare -gx rebooted_server_timeout=''
		)&
	else
		debug_log "Server reboot timer has been triggered not rebooting $server"
		echo "false"
	fi
}

function aws_restart() {
#	aws ec2 stop-instances   --instance-ids i-026c86754b14d7e09
#	aws ec2 terminate-instances --instance-ids i-026c86754b14d7e09
	aws ec2 start-instances  --instance-ids i-026c86754b14d7e09
	aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
}

function gcp_restart() {
		HOSTNAME="ctp-vpn"
		PROJECT="galvanic-pulsar-284521"
		ZONE="us-central1-a"

		gcloud compute instances stop "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT"

		gcloud compute instances start "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT"
}

if [[ `server-health-check 1.1.1.1 53` = 'true' ]] && [[ `server-health-check one.one.one.one 853` = 'true' ]] || [[ `server-health-check dns.google 853` = 'true' ]] ||  [[ `server-health-check www.google.com 443` = 'true' ]]; then

	if [[ "$server" = "gcp.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]] || [[ `server-health-check $server 853` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			gcp_restart
		else
			echo "Server $server is healthly"
		fi
	elif [[ "$server" = "home.ctptech.dev" ]]; then
		if [[ `server-health-check $server 22222` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			sudo reboot -f
		else
			echo "Server $server is healthly"
		fi
	elif [[ "$server" = "aws.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]] || [[ `server-health-check $server 853` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			aws_restart
		else
			dot_result=`bash $PROG/test_dot.sh -a $server`
			dns_result=`bash $PROG/test_dns.sh -a $server`
			if [[ `health_check_remote_port_tcp "$server" "853"` = 'true' ]] && [[ `health_check_remote_port_tcp "$server" "53"` = 'true' ]]; then
				if [[ $dot_result = 'true' ]] && [[ $dns_result = 'true' ]]; then
					echo "Server $server is unhealthy rebooting dig dug"
					aws_restart
			else
					echo "Server $server is healthly"
				fi
			else
				echo "Server $server is unhealthy rebooting"
				echo "Error $server: 11"
				aws_restart
			fi
		fi
	else
		if [[ `server-health-check aws.ctptech.dev` = 'false' ]]; then
			echo "Server aws.ctptech.dev is unhealthy rebooting"
			aws_restart
		else
			echo "Server aws.ctptech.dev is healthly"
		fi

	fi
else
	echo "Internet or DNS not working exiting"
fi
