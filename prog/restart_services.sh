#!/bin/bash

export SCRIPT_DIR=`realpath .`
source /etc/environment
source $SCRIPT_DIR/.install-args-proc.sh
source $SCRIPT_DIR/.project_env.sh
bash $SCRIPT_DIR/reload_ctp-dns.sh

sudo systemctl daemon-reload


service=unbound-resolvconf.service
sudo systemctl stop $service
sudo systemctl disable $service
sudo systemctl mask $service

service=zerotier-one
sudo systemctl stop $service
sudo systemctl disable $service
sudo systemctl mask $service

service=netdata
sudo systemctl stop $service
sudo systemctl disable $service
sudo systemctl mask $service

service=dnsmasq
sudo systemctl stop $service
sudo systemctl disable $service
sudo systemctl mask $service

service=ctp-auto-6to4.service
sudo systemctl stop $service
sudo systemctl disable $service
sudo systemctl mask $service

service=unbound
if [[ -z "$IS_MASTER" ]]; then
	sudo systemctl stop $service
	sudo systemctl disable $service
	sudo systemctl mask $service
else
	sudo systemctl unmask $service
	sudo systemctl enable $service
	sudo systemctl start $service

fi
sudo systemctl enable netfilter-persistent
sudo systemctl start netfilter-persistent

declare -a master_services
master_services=(
	'pihole-FTL.service'
	'unbound.service'
	'resolvconf.service'
)

declare -a SERVICES
SERVICES=(
	$( [[ "$IS_MASTER" == true ]] && echo "${master_services[@]}" )
	'nginx.service'
	'doh-server.service'
	'fail2ban.service'
	'nginx-dns-rfc.service'
	'tailscaled.service'
)

for service in "${SERVICES[@]}"
do
	echo "Enabling, restarting and umasking service $service"
	sudo systemctl unmask "$service"
	sudo systemctl enable "$service"
	sudo systemctl restart "$service"
	sudo systemctl status "$service" | grep ""
	echo "Done enabling, restarting and umasking service $service"
done
