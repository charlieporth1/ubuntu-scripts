#!/bin/bash
source $PROG/all-scripts-exports.sh
echo "Running: `date`"
server="$1"
function server-health-check() {
	local server="${1:-aws.ctptech.dev}"
	local port="${2:-22}"
	if [[ `ip_exists "$server"` = 'false' ]] || [[ `health_check_remote_port_tcp "$server" "$port"` == 'false' ]] ; then
		if [[ `reboot_timer $server` == 'true' ]]; then
			echo "false"
			debug_log "Server $server is unhealthy rebooting"
		else
			debug_log "Server $server is unhealthy but not rebooting because of timer"
			echo "true"
		fi
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
			debug_log "Server reboot timer has started 8m $rebooted_server_timeout"
			sleep 8m
			debug_log "Server reboot timer has finished $rebooted_server_timeout"
			declare -gx rebooted_server_timeout=''
		)&
	else
		debug_log "Server reboot timer has been triggered not rebooting $server"
		echo "false"
	fi
}

function gcp_restart() {
	if [[ `reboot_timer gcp.ctptech.dev` == 'true' ]]; then
		HOSTNAME="ctp-vpn"
		PROJECT="galvanic-pulsar-284521"
		ZONE="us-central1-a"

		gcloud compute instances stop "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT"

		gcloud compute instances start "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT"
	fi
}

if [[ `server-health-check 1.1.1.1 53` = 'true' ]] && [[ `server-health-check one.one.one.one 53` = 'true' ]]; then

	if [[ "$server" = "gcp.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]] || [[ `server-health-check $server 853` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			gcp_restart
		else
			echo "Server $server is healthly"
		fi

	elif [[ "$server" = "home.ctptech.dev" ]]; then
		if [[ `server-health-check $server 22222` = 'false' ]] || [[ `server-health-check $server 853` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			sudo reboot -f
		else
			echo "Server $server is healthly"
		fi
	elif [[ "$server" = "aws.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]] || [[ `server-health-check $server 853` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
		else
			dot_result=`bash $PROG/test_dot.sh -a $server`
			dns_result=`bash $PROG/test_dns.sh -a $server`
			if [[ `health_check_remote_port_tcp "$server" "853"` = 'true' ]] && [[ `health_check_remote_port_tcp "$server" "53"` = 'true' ]]; then
				if [[ $dot_result = 'false' ]] && [[ $dns_result = 'false' ]]; then
					echo "Server $server is unhealthy rebooting dig dug"
					aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
				else
					echo "Server $server is healthly"
				fi
			else
				echo "Server $server is unhealthy rebooting"
				echo "Error $server: 11"
				aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
			fi
		fi
	else
		if [[ `server-health-check aws.ctptech.dev` = 'false' ]]; then
			echo "Server aws.ctptech.dev is unhealthy rebooting"
			aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
		else
			echo "Server aws.ctptech.dev is healthly"
		fi

	fi
else
	echo "Internet or DNS not working exiting"
fi
