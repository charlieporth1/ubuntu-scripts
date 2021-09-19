#!/bin/bash
source $PROG/all-scripts-exports.sh
echo "Running: `date`"
server="$1"
function server-health-check() {
	local server="${1:-aws.ctptech.dev}"
	local port="${2:-22}"
	if [[ `ip_exists "$server"` = 'false' ]] && [[ `health_check_remote_port_tcp "$server" "$port"` == 'false' ]]; then
		echo "false"
		debug_log "Server $server is unhealthy rebooting"
	else
		echo "true"
		debug_log "Server $server is healthly"
	fi
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
if [[ `server-health-check 1.1.1.1 53` = 'true' ]] && [[ `server-health-check one.one.one.one 53` = 'true' ]]; then

	if [[ "$server" = "gcp.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			gcp_restart
		else
			echo "Server $server is healthly"
		fi

	elif [[ "$server" = "home.ctptech.dev" ]]; then
		if [[ `server-health-check $server 2222` = 'false' ]]; then
			echo "Server $server is unhealthy rebooting"
			sudo reboot -f
		else
			echo "Server $server is healthly"
		fi
	elif [[ "$server" = "aws.ctptech.dev" ]]; then
		if [[ `server-health-check $server` = 'false' ]]; then
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
				aws ec2 reboot-instances --instance-ids i-026c86754b14d7e09
				echo "Error $server: 11"
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
