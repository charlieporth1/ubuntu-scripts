#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/ban_ip_conf.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
IP_REGEX="((([0-9]{1,3})\.){4})"

FILE=/tmp/$FILE_NAME.grep
INGORE_IP_ADRESSES=$( cat $FILE )

if ! [[ -f $FILE ]]; then
	bash $PROG/create_ban_ignore_ip_list.sh
fi

sudo lastb -a | grep -oE "$IP_REGEX" | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set sshd banip

if [[ -n "$IS_PIHOLE" ]]; then
	echo "IS_PIHOLE $IS_PIHOLE"
        PIHOLE_F2B_REGEX=`grep 'failregex' /etc/fail2ban/filter.d/pihole-dns-1-block.conf | awk -F= '{print $2}' | cut -d '<' -f -1`
	IP_ARRAY=( $( grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | sort -u | grep -v "${INGORE_IP_ADRESSES}") )
	IP_ARRAY=( $( filter_ip_address_array ${IP_ARRAY[@]}  ) )
        echo "${IP_ARRAY[@]}" | xargs sudo fail2ban-client set pihole-dns-1-block banip
#        grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | \
#	xargs sudo fail2ban-client set ctp-dns-1-block banip
fi

sudo bash $PROG/get_bad_hosts.sh > /tmp/bad_ips.txt

cat  /tmp/bad_ips.txt | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set pihole-dns-1-block banip

create_ip-set brute abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/brute.list))
for ip in  ${ban_ips[@]}
do
        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set nuc abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/nuc-badip.list))
for ip in  ${ban_ips[@]}
do        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set nuc abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/
for ip in  ${ban_ips[@]}
do
        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL
create_ip-set routedns-badip abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/routedns-badip.list))
for ip in  ${ban_ips[@]}
do
        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set endless-badip abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/endless-badip.list))
for ip in  ${ban_ips[@]}
do
        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set fail2ban-abuse abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban))
for ip in  ${ban_ips[@]}
do
        ipset add $IPSET_BK_NAME $i
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

save_ip-tables
