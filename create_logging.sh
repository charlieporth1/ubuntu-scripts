#!/bin/bash
source /etc/environment

rm -rf $LOG/unbound.log

mkdir -p /var/log/{nginx,letsencrypt}/
mkdir -p /var/log/pihole{,_lists}
mkdir -p /var/log/{apt,ctp-dns,nginx-dns-rfc,ctp-fail-over-dns,ctp-auto-6to4,ctp-network-zeroteir,pihole-loadbalancer-ctp-dns}
mkdir -p /var/log/tailscaled

mkdir -p /var/cache/nginx/

touch $LOG/{auth,unbound,mail,fail2ban}.log
touch $LOG/{ctp-dns,nginx-dns-rfc,ctp-fail-over-dns,ctp-auto-6to4}/$DEFAULT_LOG_FILES
touch $LOG/tailscaled/$DEFAULT_LOG_FILES

chown -R www-data:www-data /var/{cache,log}/nginx/

if [[ "$IS_MATER" == 'true' ]] || [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	mkdir -p /var/{log,cache}/lighttpd/
	mkdir -p /var/cache/{dnsmasq,pihole}/

	touch $LOG/unbound.log
	touch $LOG/pihole{,-FTL}.log

	chown -R www-data:www-data /var/{log,cache}/lighttpd/
	chown -R unbound:unbound $LOG/unbound.log
	chown -R pihole:pihole $LOG/pihole{,-FTL}.log
fi


chown -R www-data:www-data $WWW
chown -R www-data:www-data $WWW/txt_lists/
chown -R www-data:www-data $CTP_LISTS
chmod -R gu+rw $WWW/txt_lists/
chmod -R gu+rw $CTP_LISTS
(
	certbot-ocsp-fetcher --output-dir=/var/cache/nginx/
	ctp-dns.sh --generate-logs
)&


chmod -R 775 /var/log/nginx
chmod -R 640 $LOG/{auth,mail}.log

chown -R syslog:adm $LOG/{auth,mail}.log
chown -R root:adm $LOG/fail2ban.log
