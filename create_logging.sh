#!/bin/bash
DEFAULT_LOG_FILES={default,access,error}.log
mkdir -p /var/log/{lighttpd,nginx,letsencrypt}
mkdir -p /var/log/pihole{,_lists}
mkdir -p /var/log/{apt,ctp-dns,nginx-dns-rfc}


touch $LOG/unbound.log
touch $LOG/pihole{-FTL,}.log
touch $LOG/auth.log
touch $LOG/{ctp-dns,nginx-dns-rfc}/$DEFAULT_LOG_FILES

chown unbound:unbound $LOG/unbound.log
chown pihole:pihole $LOG/pihole{-FTL,}.log

certbot-ocsp-fetcher --output-dir=/var/cache/nginx/
chown -R www-data:www-data /var/cache/nginx/
