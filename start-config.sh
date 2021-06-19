#!/bin/bash
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g'); done
source /etc/environment

echo 1 > /proc/sys/net/ipv4/ip_forward
echo 3 > /proc/sys/net/ipv4/tcp_fastopen

touch /var/log/unbound.log
chown -R unbound:unbound /var/log/unbound.log

mkdir -p /var/cache/nginx/{doh_cache,doh_json_cache}
chown -R www-data:www-data /var/cache/nginx/
mkdir -p /tmp/nginx/
chown -R www-data:www-data /tmp/nginx/

sudo bash $PROG/serveronline.sh
sudo bash $PROG/cpu_group_all_.sh
sudo bash $PROG/copy_certs.sh
sudo bash $PROG/update.unbound-config.sh
sudo bash $PROG/add_cache_interfaces.sh
sudo bash $PROG/pihole-db-sql-changes.sh

systemctl restart ctp-dns
systemctl restart doh-server
systemctl restart nginx

sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv4.ip_forward=1
#bash $PROG/request-remote-cache.sh

if [[ -f /swapfile ]]; then
	swapon /swapfile
fi
(
        sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/block-china.sh
        sleep 10s
        sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_countries.sh
        sleep 10s
        # This should always come after because it will unblock
        sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/set_fail2ban-defaults.sh

)&
