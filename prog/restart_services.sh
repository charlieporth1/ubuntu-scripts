#!/bin/bash

export SCRIPT_DIR=`realpath .`
source /etc/environment
source $SCRIPT_DIR/.install-args-proc.sh
source $SCRIPT_DIR/.project_env.sh
bash $SCRIPT_DIR/reload_ctp-dns.sh

sudo systemctl daemon-reload
sudo systemctl stop unbound-resolvconf.service
sudo systemctl disable unbound-resolvconf.service
sudo systemctl mask unbound-resolvconf.service

#sudo systemctl restart netdata
#sudo systemctl enable netdata
sudo systemctl disable netdata
sudo systemctl mask netdata

sudo systemctl disable dnsmasq
sudo systemctl mask dnsmasq

if [[ -z "$IS_MASTER" ]]; then
	sudo systemctl disable unbound
	sudo systemctl mask unbound
else
	sudo systemctl unmask unbound
fi

declare -a master_services
master_services=(
	'pihole-FTL.serivce'
	'unbound.service'
	'resolvconf.service'
)

declare -a SERVICES
SERVICES=(
	$( [[ "$IS_MASTER" == true ]] && echo "${master_services[@]}" )
	'nginx.service'
	'doh-server.service'
	'fail2ban.service'
)

for service in "${SERVICES[@]}"
do
	echo "Enabling, restarting and umasking service $service"
	sudo systemctl unmask "$service"
	sudo systemctl enable "$service"
	sudo systemctl restart "$service"
	echo "Done enabling, restarting and umasking service $service"
done
