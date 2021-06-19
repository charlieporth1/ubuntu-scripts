#!/bin/bash
source $PROG/all-scripts-exports.sh
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
        PIHOLE_F2B_REGEX=`grep 'failregex' /etc/fail2ban/filter.d/pihole-dns.conf | awk -F= '{print $2}' | cut -d '<' -f -1`
	IP_ARRAY=( $( grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | sort -u | grep -v "${INGORE_IP_ADRESSES}") )
	IP_ARRAY=( $( filter_ip_address_array ${IP_ARRAY[@]}  ) )
        echo "${IP_ARRAY[@]}" | xargs sudo fail2ban-client set pihole-dns-1-block banip
#        grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | \
#	xargs sudo fail2ban-client set ctp-dns-1-block banip
fi

sudo bash $PROG/get_bad_hosts.sh > /tmp/bad_ips.txt

cat  /tmp/bad_ips.txt | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set pihole-dns-1-block banip


CONFIG_DIR=/etc/ipset
! [[ -d $CONFIG_DIR ]] && mkdir -p $CONFIG_DIR
function create_ip-set() {
        local LIST_NAME="$1"

        declare -gx IPSET_BK_NAME=bad-ips-blacklist-$LIST_NAME
        declare -gx IPSET_FILE=$CONFIG_DIR/$IPSET_BK_NAME.ipset

        sudo ipset create $IPSET_BK_NAME hash:net hashsize 8192
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j DROP -w
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j DROP -w

        if [[ -f $IPSET_FILE ]]; then
                ipset restore < $IPSET_FILE
        else
                touch $IPSET_FILE
        fi

}

create_ip-set brute
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/brute.list))
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done

create_ip-set nuc
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/nuc-badip.list))
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done

create_ip-set nuc
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done

create_ip-set routedns-badip
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/routedns-badip.list))
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done


create_ip-set endless-badip
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/badip-repo/master/endless-badip.list))
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done

create_ip-set fail2ban-abuse
declare -a ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban))
for ip in  ${ban_ips[@]}
        ipset add $IPSET_BK_NAME $i
        ipset save $IPSET_BK_NAME > $IPSET_FILE
do
done

