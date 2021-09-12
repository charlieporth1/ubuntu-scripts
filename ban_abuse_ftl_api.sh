#!/bin/bash
source $PROG/ban_ip_conf.sh

IP_BAN_FILE=/tmp/ban_from_ftl_abuse.txt
IP_ADDRESSES=`echo "SELECT ip FROM network_addresses;" | sqlite3 $FTP_DB_FILE`

printf '%s\n' "${IP_ADDRESSES}" > $IP_BAN_FILE

cat $IP_BAN_FILE | find-ip-block > $IP_BAN_FILE.tmp
mv $IP_BAN_FILE.tmp $IP_BAN_FILE
run_ip-set-block-file $IP_BAN_FILE
