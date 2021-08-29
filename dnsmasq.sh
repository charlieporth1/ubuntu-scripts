#!/bin/bash

source /etc/environment
shopt -s expand_aliases

SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.project_env.sh
DNSM_CONF_DIR=$CONFIG_DIR/dnsmasq.d

if [[ "$IS_AWS" = 'true' ]]; then
	VPN_TUNNEL_IP='10.128.0.9'
	declare -a GCP_DOMAIN_SERVERS
	GCP_DOMAIN_SERVERS=(
		`grep -E "(35\.192\.105\.158|35\.232\.120\.211)" $DNSM_CONF_DIR/88-custom-dns-servers.conf | perl -pe " s/(35\.192\.105\.158|35\.232\.120\.211)$//gm "`
	)
	for domain_line in "${GCP_DOMAIN_SERVERS[@]}"
	do
			echo "$domain_line$VPN_TUNNEL_IP" | sudo tee -a $DNSM_CONF_DIR/88-custom-dns-servers.conf
	done
	echo "server=$VPN_TUNNEL_IP" | sudo tee -a $DNSM_CONF_DIR/88-custom-dns-servers.conf
	cp -rf $DNSM_CONF_DIR/ $INSTALL_CONFIG_DIR/
fi
