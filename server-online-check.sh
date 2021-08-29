#!/bin/bash
source $PROG/all-scripts-exports.sh
echo "Running: `date`"
server="$1"
if [[ "$server" = "gcp.ctptech.dev" ]]; then
	if [[ `ip_exists $server` = 'false' ]]; then
		echo "Server $server is unhealthy rebooting"
		HOSTNAME="ctp-vpn"
		PROJECT="galvanic-pulsar-284521"
		ZONE="us-central1-a"
		gcloud compute instances stop "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT" \
		gcloud compute instances start "$HOSTNAME" \
			--zone "$ZONE" \
			--project "$PROJECT" \
	else
		echo "Server $server is healthly"
	fi
else
	if [[ `ip_exists aws.ctptech.dev` = 'false' ]]; then
		echo "Server aws.ctptech.dev is unhealthy rebooting"
#		aws ec2  reboot-instances --instance-ids  i-026c86754b14d7e09
	else
		echo "Server aws.ctptech.dev is healthly"
	fi

fi
