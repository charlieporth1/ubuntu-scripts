#!/bin/bash
SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.project_env.sh
domains_replace="dns.ctptech.dev master.dns.ctptech.dev"
if [[ -n "$DOMAIN" ]]; then
	echo "$DOMAIN adding domain to domains"
	domains_replace="$domains_replace $DOMAIN"
fi
current_str="server_name  dns.ctptech.dev;"
replace_str="server_name  $domains_replace;"

sed -i "s/$current_str/$replace_str/g" $SITES/doh
sudo nginx -t
