#!/bin/bash
source $PROG/ban_ip_conf.sh
CONCURRENT

sudo lastb -a | grepip -o | grep -v "${INGORE_IP_ADRESSES}" | find-ip-block > /tmp/ban_abuse_ips_ssh.list

jail=sshd
cat /tmp/ban_abuse_ips_ssh.list | xargs sudo fail2ban-client set $jail banip

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
	jail=pihole-dns-1-block

	PIHOLE_LOG_QUERY_TAIL=`tail -7500 $PIHOLE_LOG | grep 'query'`
	BLOCKED_TLDS=$(grepify $HOLE/tld-blacklist.list | sed 's/\./\\./g')

	FREQ_QUERIES_TO_BLOCK_1="(^\.|^sl|hitnslab|query|open-resolver-scan\.research\.icann\.org|internet-census\.org|\.test|tictok|localhost|(((version|hostname)\.)?)bind))$"
	FREQ_QUERIES_TO_BLOCK_2="(xiaomi|miui|footprintdns|tiktokcdn|pizzaseo|parrotdns|spiderprobe|tiktokv|www\.123|anticheatexpert)\.(net|com)"
	FREQ_QUERIES_TO_BLOCK="($BLOCKED_TLDS|$FREQ_QUERIES_TO_BLOCK_1|$FREQ_QUERIES_TO_BLOCK_2)"



	PIZZASEO_BS=`printf '%s\n' "$PIHOLE_LOG_QUERY_TAIL" | grep -E "$FREQ_QUERIES_TO_BLOCK" | find-ip-block`

        printf '%s\n' "${PIZZASEO_BS}" > /tmp/ban_abuse_ips.list

	create_ip-set dns-log abuse
	run_ip-set-block-file /tmp/ban_abuse_ips.list
	cat /tmp/ban_abuse_ips_ssh.list | xargs sudo fail2ban-client set $jail banip

fi
