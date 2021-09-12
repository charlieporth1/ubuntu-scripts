#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/name-server-conf.sh
DATETIME_FOLDER=$(date '+%d-%m-%Y-%H%M%S')

curl https://public-dns.info/nameserver/us.txt | grepip  --only-matching --exclude-reserved | ip-sort | sudo tee /tmp/public_dns-servers.txt
curl https://dnschecker.org/public-dns/us | grepip  --only-matching --exclude-reserved | ip-sort | sudo tee -a /tmp/public_dns-servers.txt

cat /tmp/public_dns-servers.txt | ip-sort > /tmp/public_dns-servers.txt.bk
mv /tmp/public_dns-servers.txt.bk /tmp/public_dns-servers.txt

printf '%s\n' "$( cat /tmp/public_dns-servers.txt )" | sudo tee -a $DNS_LIST_FILE
printf '%s\n' "$( cat $QUAD_LIST_DNS_SERVERS_OUT_FILE ) " | sudo tee -a $DNS_LIST_FILE

perl -i -ne 'print if ! $x{$_}++' $DNS_LIST_FILE
#mv $DNS_LIST_FILE.tmp $DNS_LIST_FILE
