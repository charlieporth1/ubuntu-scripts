#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
DEFUALT_FILE=/tmp/$FILE_NAME.txt
if [[ ]]
mapfile -t DNS_IGNORE_IPs < $DEFUALT_FILE

declare -a JAIL_PIHOLEs
JAIL_PIHOLEs=(
        pihole-dns-1-block
        pihole-dns
)

declare -a JAILs
JAILs=(
        $( [[ -n "$IS_PIHOLE" ]] && ${JAIL_PIHOLEs[@]} )
        ctp-dns-1-block
        sshd
        nginx-http-auth
)



for jail in "${JAILs[@]}"
do
        sudo fail2ban-client $jail start
        sudo fail2ban-client set $jail addignoreip ${DNS_IGNORE_IPs[@]}
        sudo fail2ban-client set $jail unbanip ${DNS_IGNORE_IPs[@]}
done
sudo iptables-save
