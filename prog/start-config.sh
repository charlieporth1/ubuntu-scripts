#!/bin/bash
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g'); done
source /etc/environment
source $PROG/all-scripts-exports.sh

mkdir -p /var/cache/nginx/{doh_cache,doh_json_cache}
chown -R www-data:www-data /var/cache/nginx/
mkdir -p /tmp/nginx/
chown -R www-data:www-data /tmp/nginx/

bash $PROG/cpu_group_all_.sh
bash $PROG/copy_certs.sh
bash $PROG/start_fail2ban_jails.sh
bash $PROG/modprobes.sh
bash $PROG/incresse_perf.sh
bash $PROG/serveronline.sh
bash $PROG/create_logging.sh
bash $PROG/start_tailscale.sh

NET_DEV_NAME=$(bash $PROG/get_network_devices_names.sh --default --single)
sudo systemd-resolve --set-mdns=yes --interface=tailscale0,$NET_DEV_NAME

if [[ "$IS_MASTER" == 'true' ]]; then
#	bash $PROG/add_cache_interfaces.sh
	bash $PROG/add_cache_interfaces_lo_cache.sh
	bash $PROG/pihole-db-sql-changes.sh
	bash $PROG/update.unbound-config.sh
	bash $PROG/start_processes.sh

fi

#bash $PROG/request-remote-cache.sh

if [[ -f /swapfile ]]; then
	swapon /swapfile
fi
(
        if [[ $MEM_COUNT -ge 750 ]]; then
		sudo bash $PROG/iptables-load.sh
		sleep 2m
		if [[ "$IS_MASTER" == 'true' ]]; then
			echo "1111"
#			bash $PROG/copy_gravity.sh --health-check-gravity &
			bash $PROG/pihole-db-sql-changes.sh
		fi
	else
	        sleep 10
	        # This should always come after because it will unblock
	        sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/set_fail2ban-defaults.sh

        fi
	bash $PROG/copy_gravity.sh --health-check-gravity &
)&
