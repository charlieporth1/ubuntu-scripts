#!/bin/bash
source $PROG/ban_ip_conf.sh
CONCURRENT


sudo lastb -a | grep -oE "$IP_REGEX" | grep -v "${INGORE_IP_ADRESSES}" > /tmp/ban_abuse_ips_ssh.list
create_ip-set ssh-log abuse
run_ip-set-block-file /tmp/ban_abuse_ips_ssh.list

if [[ "$IS_PIHOLE" == 'true' ]]; then
	echo "IS_PIHOLE $IS_PIHOLE"
	BLOCKED_QUERIES_FILE=$HOLE/vulnerability-blacklist.regex
#	if [[ -f $BLOCKED_QUERIES_FILE ]]; then
#	        PIHOLE_F2B_REGEX=` | awk -F= '{print $2}' | cut -d '<' -f -1`
#	IP_ARRAY=( $( printf '%s\n' "$PIHOLE_LOG_QUERY_TAIL" | find-ip-block) )
#        echo "${IP_ARRAY[@]}" | xargs sudo fail2ban-client set ctp-dns-1-block banip
#	fi

	PIHOLE_LOG_QUERY_TAIL=`tail -7500 $PIHOLE_LOG | grep 'query'`

	FREQ_QUERIES_TO_BLOCK="(^\.|^sl|hitnslab|query|open-resolver-scan\.research\.icann\.org|internet-census\.org|pizzaseo\.com|ip\.parrotdns\.com|parrotdns\.com|\.test)$"



	PIZZASEO_BS=`printf '%s\n' "$PIHOLE_LOG_QUERY_TAIL" | grep -E "$FREQ_QUERIES_TO_BLOCK" | find-ip-block`

        printf '%s\n' "${PIZZASEO_BS}" > /tmp/ban_abuse_ips.list

	create_ip-set dns-log abuse
	run_ip-set-block-file /tmp/ban_abuse_ips.list
#| xargs sudo fail2ban-client set ctp-dns-1-block-ipset banip
#        grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | \
#	xargs sudo fail2ban-client set ctp-dns-1-block banip
fi
