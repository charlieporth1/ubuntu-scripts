#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
IP_REGEX="((([0-9]{1,3})\.){4})"

INGORE_IP_ADRESSES=$( cat /tmp/$FILE_NAME.grep )


sudo lastb -a | grep -oE "$IP_REGEX" | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set sshd banip

if [[ -n "$IS_PIHOLE" ]]; then
        PIHOLE_F2B_REGEX=`grep 'failregex' /etc/fail2ban/filter.d/pihole-dns-1-block.conf | awk -F= '{print $2}' | cut -d '<' -f -1`

        grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | \
	xargs sudo fail2ban-client set ctp-dns-1-block banip
        grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | \
	xargs sudo fail2ban-client set pihole-dns-1-block banip
fi

sudo bash $PROG/get_bad_hosts.sh > /tmp/bad_ips.txt

cat  /tmp/bad_ips.txt | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set pihole-dns-1-block banip
