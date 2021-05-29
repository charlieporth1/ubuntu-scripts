#!/bin/bash
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g'); done
source /etc/environment 
echo 1 > /proc/sys/net/ipv4/ip_forward

touch /var/log/unbound.log
chown -R unbound:unbound /var/log/unbound.log

mkdir -p /var/cache/nginx/{doh_cache,doh_json_cache}
chown -R www-data:www-data /var/cache/nginx/
mkdir -p /tmp/nginx/
chown -R www-data:www-data /tmp/nginx/

bash $PROG/copy_certs.sh
bash $PROG/update.unbound-config.sh
bash $PROG/add_cache_interfaces.sh
#bash $PROG/doq-and-failover-bootstrap-server.sh

systemctl mask unbound

systemctl restart ctp-dns
systemctl restart doh-server
systemctl restart nginx

sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv4.ip_forward=1
sudo bash $PROG/cpu_group_all_.sh
#bash $PROG/request-remote-cache.sh

if [[ -f /swapfile ]]; then
	swapon /swapfile
fi

