#!/bin/bash
declare -xg ADDITONAL_ROUTES=""
GCP_AWS_ROUTE="10.128.0.0/16,172.31.0.0/16"
GCP_ROUTE="10.128.0.0/16,192.168.99.0/24"
HOME_ROUTE="192.168.44.0/24"

function add_routes() {
	local route="$1"
	if [[ -z $ADDITONAL_ROUTES ]]; then
		ADDITONAL_ROUTES="$route"
	else
		ADDITONAL_ROUTES="$ADDITONAL_ROUTES,$route"
	fi
}
if [[ "$HOSTNAME" =~ (ctp-vpn|ip-172-31-12-154) ]]; then
	add_routes "$GCP_AWS_ROUTE"
#	if [[ "$HOSTNAME" = 'ctp-vpn' ]]; then
#
#	fi
elif [[ "$HOSTNAME" = "ubuntu-server" ]]; then
	add_routes "$HOME_ROUTE"
fi
if [[ -n "$ADDITONAL_ROUTES" ]]; then
	echo "Starting TailScale adding ROUTES $ADDITONAL_ROUTES"
	sudo tailscale up --advertise-routes=$ADDITONAL_ROUTES --accept-routes --advertise-exit-node
else
	sudo tailscale up --accept-routes --advertise-exit-node
fi

