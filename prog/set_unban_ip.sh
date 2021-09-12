#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/ban_ip_conf.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
DEFUALT_FILE=/tmp/$FILE_NAME.txt

if ! [[ -f $DEFUALT_FILE ]]; then
        bash $PROG/create_ban_ignore_ip_list.sh
fi

mapfile -t DNS_IGNORE_IPs < $DEFUALT_FILE
mapfile -t TMOBILE_IGNORE_IPs < $INGNORE_IP_TMOBILE


declare -a JAIL_PIHOLEs
JAIL_PIHOLEs=(
        pihole-dns-1-block
        pihole-dns
)

declare -a JAILs
JAILs=(
        $( [[ -n "$IS_PIHOLE" ]] && echo ${JAIL_PIHOLEs[@]} )
        ctp-dns-1-block
        sshd
        nginx-http-auth
)


create_ip-set-allow dns-list allow
for ip in "${DNS_IGNORE_IPs[@]}"
do
	ipset add $IPSET_BK_NAME $ip
done

create_ip-set-allow tmobile-list allow
for ip in "${TMOBILE_IGNORE_IPs[@]}"
do
	ipset add $IPSET_BK_NAME $ip
done

for jail in "${JAILs[@]}"
do
        sudo fail2ban-client $jail start

        echo ${DNS_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail addignoreip
	echo ${DNS_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail unbanip

        echo ${TMOBILE_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail addignoreip
	echo ${TMOBILE_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail unbanip
done
save_ip-tables
