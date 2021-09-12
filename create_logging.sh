#!/bin/bash
source /etc/environment
DEFAULT_LOG_FILES='{default,access,error}.log'

ctp-dns.sh --generate-logs
certbot-ocsp-fetcher --output-dir=/var/cache/nginx/

mkdir -p /var/log/{nginx,letsencrypt}/
mkdir -p /var/log/pihole{,_lists}
mkdir -p /var/log/{apt,ctp-dns,nginx-dns-rfc}


touch $LOG/auth.log
touch $LOG/{ctp-dns,nginx-dns-rfc}/$DEFAULT_LOG_FILES


chown -R www-data:www-data /var/{cache,log}/nginx/

if [[ "$IS_MATER" == 'true' ]] || [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	mkdir -p /var/{log,cache}/lighttpd/

	touch $LOG/unbound.log
	touch $LOG/pihole{,-FTL}.log

	chown -R www-data:www-data /var/{log,cache}/lighttpd/
	chown -R unbound:unbound $LOG/unbound.log
	chown -R pihole:pihole $LOG/pihole{-FTL,}.log
fi

